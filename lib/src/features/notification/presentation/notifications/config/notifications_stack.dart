import 'package:tuku_shop/src/features/notification/presentation/notifications/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

class NotificationsStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: NotificationsRoutes.notifications.path,
      name: NotificationsRoutes.notifications.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationScreen();
      },
      routes: <RouteBase>[],
    ),
  ];
}
