import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../cart/cart_screen.dart';

class CartStack {
  static final List<RouteBase> tabRoutes = <RouteBase>[
    GoRoute(
      path: AppRoutes.cart.path,
      name: AppRoutes.cart.name,
      builder: (_, _) => const CartScreen(),
    ),
  ];
}
