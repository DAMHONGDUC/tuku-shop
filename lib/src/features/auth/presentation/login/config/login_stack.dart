import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/presentation/register/register_screen.dart';

import '../login_screen.dart';

class LoginStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: LoginRoutes.login.path,
      name: LoginRoutes.login.name,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    SdGoRouteV5(
      path: RegisterRoutes.register.path,
      name: RegisterRoutes.register.name,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
  ];
}
