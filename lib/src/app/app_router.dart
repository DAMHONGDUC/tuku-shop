import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/presentation/config/auth_stack.dart';
import 'package:tuku_shop/src/features/cart/presentation/config/cart_stack.dart';
import 'package:tuku_shop/src/features/checkout/presentation/config/checkout_stack.dart';
import 'package:tuku_shop/src/features/home/presentation/config/home_stack.dart';
import 'package:tuku_shop/src/features/notification/presentation/config/notification_stack.dart';
import 'package:tuku_shop/src/features/onboarding/config/onboarding_stack.dart';
import 'package:tuku_shop/src/features/order/presentation/config/order_stack.dart';
import 'package:tuku_shop/src/features/product/presentation/config/product_stack.dart';
import 'package:tuku_shop/src/features/profile/presentation/config/profile_stack.dart';
import 'package:tuku_shop/src/features/splash/config/splash_stack.dart';

import 'shell/app_shell.dart';

/// The route tree. Full-screen routes sit at the top level, so they cover
/// the tab bar; the five tabs are branches of one shell and keep their own
/// back stacks.
abstract final class AppRouter {
  static final GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  static final GoRouter router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: AppRoutes.splash.path,
    routes: <RouteBase>[
      ...SplashStack.routes,
      ...OnboardingStack.routes,
      ...AuthStack.routes,
      StatefulShellRoute(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell shell,
            ) => AppShell(navigationShell: shell),
        navigatorContainerBuilder:
            (
              BuildContext context,
              StatefulNavigationShell shell,
              List<Widget> children,
            ) => FadingBranchContainer(
              currentIndex: shell.currentIndex,
              children: children,
            ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(routes: HomeStack.tabRoutes),
          StatefulShellBranch(routes: ProductStack.shopTabRoutes),
          StatefulShellBranch(routes: ProductStack.wishlistTabRoutes),
          StatefulShellBranch(routes: CartStack.tabRoutes),
          StatefulShellBranch(routes: ProfileStack.tabRoutes),
        ],
      ),
      ...ProductStack.routes,
      ...CheckoutStack.routes,
      ...OrderStack.routes,
      ...NotificationStack.routes,
      ...ProfileStack.routes,
    ],
  );
}
