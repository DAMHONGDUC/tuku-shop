import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/home/presentation/config/home_routes.dart';
import 'package:tuku_shop/src/features/auth/presentation/login/config/login_routes.dart';
import 'package:tuku_shop/src/features/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart' hide SdContextV2X;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SplashController>()..checkLoginStatus(),
      child: _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashController, SplashState>(
      listener: (context, state) {
        if (state is LoggedInLState) {
          GoRouter.of(context).go(HomeRoutes.home.fullPath);
        } else if (state is NotLogInLState) {
          GoRouter.of(context).go(LoginRoutes.login.fullPath);
        }
      },
      child: SdAdaptiveStatusBarV5(
        backgroundColor: context.colorTheme.primary,
        child: Scaffold(
          backgroundColor: context.colorTheme.primary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.loc.app_name,
                  style: context.textTheme.heading40.whiteText(),
                ),
                SdVerticalSpacingV5(xRatio: 0.5),
                Text(
                  context.loc.splash_description,
                  style: context.textTheme.body16.whiteText(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
