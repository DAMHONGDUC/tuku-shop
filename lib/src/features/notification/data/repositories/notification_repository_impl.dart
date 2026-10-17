import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:tuku_shop/src/features/notification/data/mapper/notification_model_to_notification_entity_mapper.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({required this.dataSource});

  final NotificationRemoteDataSource dataSource;

  static const String _tag = 'NotificationRepository';

  final StreamController<int> _unread = StreamController<int>.broadcast();

  @override
  Stream<int> watchUnreadCount() async* {
    yield dataSource.unreadCount;
    yield* _unread.stream;
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      final List<NotificationEntity> items =
          (await dataSource.getNotifications())
              .map(NotificationModelToNotificationEntityMapper.toEntity)
              .toList();
      return Right<Failure, List<NotificationEntity>>(items);
    } catch (e, stackTrace) {
      SdLogger.error(_tag, 'Load failed', error: e, stackTrace: stackTrace);
      return const Left<Failure, List<NotificationEntity>>(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> markRead(String id) async {
    try {
      await dataSource.markRead(id);
      _unread.add(dataSource.unreadCount);
      return const Right<Failure, Unit>(unit);
    } catch (e, stackTrace) {
      SdLogger.error(
        _tag,
        'Mark read failed',
        error: e,
        stackTrace: stackTrace,
      );
      return const Left<Failure, Unit>(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> markAllRead() async {
    try {
      await dataSource.markAllRead();
      _unread.add(dataSource.unreadCount);
      return const Right<Failure, Unit>(unit);
    } catch (e, stackTrace) {
      SdLogger.error(
        _tag,
        'Mark all read failed',
        error: e,
        stackTrace: stackTrace,
      );
      return const Left<Failure, Unit>(ServerFailure());
    }
  }
}
