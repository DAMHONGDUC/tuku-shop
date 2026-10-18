import 'package:tuku_shop/src/features/profile/presentation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:tuku_shop/src/features/order/presentation/my_orders/config/my_order_stack.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import 'package:tuku_shop/src/core/navigation/routes/profile_routes.dart';

class ProfileStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: ProfileRoutes.profile.path,
      name: ProfileRoutes.profile.name,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
      routes: <RouteBase>[...MyOrderStack.routes],
    ),
  ];
}
