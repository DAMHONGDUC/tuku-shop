import 'package:tuku_shop/src/core/core.dart';

import '../repositories/notification_repository.dart';

class WatchUnreadCountUsecase implements StreamUseCase<int, NoParams> {
  WatchUnreadCountUsecase(this.repository);

  final NotificationRepository repository;

  @override
  Stream<int> call(NoParams params) => repository.watchUnreadCount();
}
