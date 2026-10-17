import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/notification_repository.dart';

class MarkNotificationReadUsecase implements UseCase<Unit, String> {
  MarkNotificationReadUsecase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Either<Failure, Unit>> call(String params) =>
      repository.markRead(params);
}
