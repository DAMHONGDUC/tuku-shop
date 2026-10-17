import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import '../login_screen.dart';
import '../otp/login_otp_screen.dart';
import 'login_routes.dart';

class LoginStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: LoginRoutes.login.path,
      name: LoginRoutes.login.name,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
      routes: [
        SdGoRouteV5(
          path: LoginRoutes.loginOtp.path,
          name: LoginRoutes.loginOtp.name,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginOTPScreen();
          },
        ),
      ],
    ),
  ];
}
