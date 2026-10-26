import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/navigation/router_config.dart';
import 'package:tuku_shop/src/features/category/presentation/categories/config/categories_stack.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_list/config/chat_list_stack.dart';
import 'package:tuku_shop/src/features/home/presentation/config/home_stack.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/config/profile_stack.dart';
import 'package:tuku_shop/src/features/notification/presentation/notifications/config/notifications_stack.dart';

import 'bottom_tab_base_screen.dart';

class BottomTabStack {
  static final statefulShellRoute = StatefulShellRoute.indexedStack(
    builder:
        (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return BottomTabBaseScreen(navigationShell: navigationShell);
        },
    branches: [
      StatefulShellBranch(
        navigatorKey: kHomeTabNavigatorKey,
        routes: <RouteBase>[...HomeStack.routes],
      ),
      StatefulShellBranch(
        navigatorKey: kCategoriesTabNavigatorKey,
        routes: <RouteBase>[...CategoriesStack.routes],
      ),
      StatefulShellBranch(
        navigatorKey: kChatTabNavigatorKey,
        routes: <RouteBase>[...ChatListStack.routes],
      ),
      StatefulShellBranch(
        navigatorKey: kNotificationsTabNavigatorKey,
        routes: <RouteBase>[...NotificationsStack.routes],
      ),
      StatefulShellBranch(
        navigatorKey: kProfileTabNavigatorKey,
        routes: <RouteBase>[...ProfileStack.routes],
      ),
    ],
  );
}
