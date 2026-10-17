import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/notification_repository.dart';

class MarkAllNotificationsReadUsecase implements UseCase<Unit, NoParams> {
  MarkAllNotificationsReadUsecase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) =>
      repository.markAllRead();
}
