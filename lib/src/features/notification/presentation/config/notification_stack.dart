import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../notifications/notifications_screen.dart';

class NotificationStack {
  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.notifications.path,
      name: AppRoutes.notifications.name,
      builder: (_, _) => const NotificationsScreen(),
    ),
  ];
}
