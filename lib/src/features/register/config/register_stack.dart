import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import '../otp/register_otp_screen.dart';
import '../register_screen.dart';
import 'register_routes.dart';

class RegisterStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: RegisterRoutes.register.path,
      name: RegisterRoutes.register.name,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
      routes: [
        SdGoRouteV5(
          path: RegisterRoutes.registerOtp.path,
          name: RegisterRoutes.registerOtp.name,
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterOTPScreen();
          },
        ),
      ],
    ),
  ];
}
