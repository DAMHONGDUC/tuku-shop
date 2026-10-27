import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

class GetUnreadNotificationCountUsecase implements UseCase<int, NoParams> {
  final NotificationRepository repository;

  GetUnreadNotificationCountUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) =>
      repository.getUnreadCount();
}

class AddNotificationUsecase implements UseCase<Unit, NewNotification> {
  final NotificationRepository repository;

  AddNotificationUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NewNotification params) =>
      repository.add(params);
}

class MarkAllNotificationsReadUsecase implements UseCase<Unit, NoParams> {
  final NotificationRepository repository;

  MarkAllNotificationsReadUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) =>
      repository.markAllRead();
}

class WatchNotificationChangesUsecase {
  final NotificationRepository repository;

  WatchNotificationChangesUsecase(this.repository);

  Stream<void> call() => repository.watchChanges();
}

class ResetNotificationsUsecase implements UseCase<Unit, NoParams> {
  final NotificationRepository repository;

  ResetNotificationsUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.reset();
}
