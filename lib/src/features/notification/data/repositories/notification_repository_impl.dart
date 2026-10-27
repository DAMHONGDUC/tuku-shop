import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/data/data_sources/notification_local_data_source.dart';
import 'package:tuku_shop/src/features/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:tuku_shop/src/features/notification/data/mapper/notification_category_model_to_notification_category_mapper.dart';
import 'package:tuku_shop/src/features/notification/data/mapper/notification_model_to_notification_entity_mapper.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_model.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required this.dataSource,
    required this.localDataSource,
  });

  final NotificationRemoteDataSource dataSource;
  final NotificationLocalDataSource localDataSource;
  final _changes = StreamController<void>.broadcast();

  /// App-raised notifications on top of the feed, read state applied.
  Future<List<NotificationModel>> _merged() async {
    final results = await Future.wait([
      Future.sync(localDataSource.getAdded),
      Future.sync(dataSource.getNotifications),
    ]);
    final read = await localDataSource.getReadIds();
    return [
      for (final n in [...results[0], ...results[1]])
        NotificationModel(
          id: n.id,
          title: n.title,
          body: n.body,
          timestamp: n.timestamp,
          isRead: (n.isRead ?? false) || read.contains(n.id),
          type: n.type,
          relatedItemId: n.relatedItemId,
        ),
    ];
  }

  @override
  Stream<void> watchChanges() => _changes.stream;

  @override
  Future<Either<Failure, NotificationData>> getNotificationData() async {
    try {
      // Future.sync: a synchronous throw still lands in Future.wait.
      final results = await Future.wait([
        Future.sync(_merged),
        Future.sync(dataSource.getNotificationCategories),
      ]);
      return Right(
        NotificationData(
          listNotification: (results[0] as List<NotificationModel>)
              .map(NotificationModelToNotificationEntityMapper.toEntity)
              .toList(),
          listNotificationCategory: (results[1] as List)
              .map(
                (c) =>
                    NotificationCategoryModelToNotificationCategoryMapper.toEntity(
                      c,
                    ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      return Right((await _merged()).where((n) => n.isRead != true).length);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> add(NewNotification n) async {
    try {
      final now = DateTime.now();
      await localDataSource.add(
        NotificationModel(
          id: 'L${now.microsecondsSinceEpoch}',
          title: n.title,
          body: n.body,
          timestamp: now,
          type: n.type,
          relatedItemId: n.relatedItemId,
        ),
      );
      _changes.add(null);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> markAllRead() async {
    try {
      final all = await _merged();
      await localDataSource.saveReadIds({for (final n in all) ?n.id});
      _changes.add(null);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> reset() async {
    try {
      await localDataSource.reset();
      _changes.add(null);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
