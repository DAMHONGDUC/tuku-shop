import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationData>> getNotificationData();

  Future<Either<Failure, int>> getUnreadCount();

  Future<Either<Failure, Unit>> add(NewNotification notification);

  Future<Either<Failure, Unit>> markAllRead();

  /// Ticks after a notification is added or read.
  Stream<void> watchChanges();

  Future<Either<Failure, Unit>> reset();
}
