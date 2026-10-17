import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:tuku_shop/src/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

import 'presentation/notifications/notifications_controller.dart';

class NotificationDi {
  static void config() {
    getIt.registerLazySingleton<NotificationRemoteDataSource>(
      NotificationRemoteDataSourceImpl.new,
    );
    getIt.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(dataSource: getIt()),
    );

    getIt.registerLazySingleton<GetNotificationsUsecase>(
      () => GetNotificationsUsecase(getIt()),
    );
    getIt.registerLazySingleton<MarkNotificationReadUsecase>(
      () => MarkNotificationReadUsecase(getIt()),
    );
    getIt.registerLazySingleton<MarkAllNotificationsReadUsecase>(
      () => MarkAllNotificationsReadUsecase(getIt()),
    );
    getIt.registerLazySingleton<WatchUnreadCountUsecase>(
      () => WatchUnreadCountUsecase(getIt()),
    );

    getIt.registerFactory<NotificationsController>(
      () => NotificationsController(
        getNotifications: getIt(),
        markRead: getIt(),
        markAllRead: getIt(),
      ),
    );
  }
}
