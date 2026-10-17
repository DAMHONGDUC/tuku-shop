import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../wishlist_screen.dart';

class WishlistStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: WishlistRoutes.wishlist.path,
      name: WishlistRoutes.wishlist.name,
      builder: (BuildContext context, GoRouterState state) {
        return const WishlistScreen();
      },
    ),
  ];
}
