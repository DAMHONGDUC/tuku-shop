import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/order/presentation/my_orders/config/my_order_stack.dart';
import 'package:tuku_shop/src/features/profile/presentation/edit_profile/edit_profile_screen.dart';

import '../profile_screen.dart';

class ProfileStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: ProfileRoutes.profile.path,
      name: ProfileRoutes.profile.name,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
      routes: <RouteBase>[
        ...MyOrderStack.routes,
        SdGoRouteV5(
          path: ProfileRoutes.editProfile.path,
          name: ProfileRoutes.editProfile.name,
          parentNavigatorKey: kRootNavigatorKey,
          builder: (BuildContext context, GoRouterState state) {
            return EditProfileScreen(user: state.extra! as UserEntity);
          },
        ),
      ],
    ),
  ];
}
