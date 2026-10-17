import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUsecase
    implements UseCase<List<NotificationEntity>, NoParams> {
  GetNotificationsUsecase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(NoParams params) =>
      repository.getNotifications();
}
