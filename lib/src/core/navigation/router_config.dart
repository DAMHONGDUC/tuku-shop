import 'package:tuku_shop/src/core/navigation/extra_codec_config.dart';
import 'package:tuku_shop/src/features/bottom_tab/bottom_tab_stack.dart';
import 'package:tuku_shop/src/features/address/presentation/address_book/config/address_stack.dart';
import 'package:tuku_shop/src/features/auth/presentation/login/config/login_stack.dart';
import 'package:tuku_shop/src/features/cart/presentation/cart/config/cart_stack.dart';
import 'package:tuku_shop/src/features/checkout/presentation/checkout/config/checkout_stack.dart';
import 'package:tuku_shop/src/features/order/presentation/my_orders/config/my_order_stack.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/config/product_stack.dart';
import 'package:tuku_shop/src/core/navigation/routes/splash_routes.dart';
import 'package:tuku_shop/src/features/splash/config/splash_stack.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_thread/config/chat_thread_stack.dart';
import 'package:tuku_shop/src/features/tutorial/config/tutorial_stack.dart';
import 'package:tuku_shop/src/features/wishlist/presentation/wishlist/config/wishlist_stack.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> kRootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GlobalKey<NavigatorState> kHomeTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeTabNav');
final GlobalKey<NavigatorState> kCategoriesTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'categoriesTabNav');
final GlobalKey<NavigatorState> kChatTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'chatTabNav');
final GlobalKey<NavigatorState> kNotificationsTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'notificationsTabNav');
final GlobalKey<NavigatorState> kProfileTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'profileTabNav');

final GoRouter kAppRouter = GoRouter(
  observers: [],
  navigatorKey: kRootNavigatorKey,
  initialLocation: SplashRoutes.splash.path,
  debugLogDiagnostics: true,
  extraCodec: const ExtraCodecConfig(),
  routes: [
    ...SplashStack.routes,
    ...TutorialStack.routes,
    ...LoginStack.routes,
    ...ProductStack.routes,
    ...CartStack.routes,
    ...WishlistStack.routes,
    ...ChatThreadStack.routes,
    ...CheckoutStack.routes,
    ...AddressStack.routes,
    ...MyOrderStack.rootRoutes,
    BottomTabStack.statefulShellRoute,
  ],
);
