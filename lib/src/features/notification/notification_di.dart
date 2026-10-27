import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/notification/data/data_sources/notification_local_data_source.dart';
import 'package:tuku_shop/src/features/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:tuku_shop/src/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/presentation/notification_badge/notification_badge_controller.dart';
import 'package:tuku_shop/src/features/notification/presentation/notifications/notifications_controller.dart';

class NotificationDi {
  static config() {
    getIt.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(),
    );

    getIt.registerLazySingleton<NotificationLocalDataSource>(
      () => NotificationLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(
        dataSource: getIt<NotificationRemoteDataSource>(),
        localDataSource: getIt<NotificationLocalDataSource>(),
      ),
    );
    getIt.registerLazySingleton<GetUnreadNotificationCountUsecase>(
      () => GetUnreadNotificationCountUsecase(getIt<NotificationRepository>()),
    );
    getIt.registerLazySingleton<AddNotificationUsecase>(
      () => AddNotificationUsecase(getIt<NotificationRepository>()),
    );
    getIt.registerLazySingleton<MarkAllNotificationsReadUsecase>(
      () => MarkAllNotificationsReadUsecase(getIt<NotificationRepository>()),
    );
    getIt.registerLazySingleton<WatchNotificationChangesUsecase>(
      () => WatchNotificationChangesUsecase(getIt<NotificationRepository>()),
    );
    getIt.registerLazySingleton<ResetNotificationsUsecase>(
      () => ResetNotificationsUsecase(getIt<NotificationRepository>()),
    );

    getIt.registerLazySingleton<GetNotificationsUsecase>(
      () => GetNotificationsUsecase(getIt<NotificationRepository>()),
    );

    getIt.registerFactory<NotificationsController>(
      () => NotificationsController(
        getIt<GetNotificationsUsecase>(),
        getIt<MarkAllNotificationsReadUsecase>(),
      ),
    );
    // App-wide: one instance, provided above the router.
    getIt.registerLazySingleton<NotificationBadgeController>(
      () => NotificationBadgeController(
        getIt<GetUnreadNotificationCountUsecase>(),
        getIt<WatchNotificationChangesUsecase>(),
      ),
    );
  }
}
