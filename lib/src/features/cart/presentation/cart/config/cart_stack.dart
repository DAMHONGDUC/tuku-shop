import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../cart_screen.dart';

class CartStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: CartRoutes.cart.path,
      name: CartRoutes.cart.name,
      builder: (BuildContext context, GoRouterState state) {
        return const CartScreen();
      },
    ),
  ];
}
