import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../splash_screen.dart';

class SplashStack {
  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.splash.path,
      name: AppRoutes.splash.name,
      pageBuilder: (_, GoRouterState state) =>
          AppPage.fade(state, const SplashScreen()),
    ),
  ];
}
