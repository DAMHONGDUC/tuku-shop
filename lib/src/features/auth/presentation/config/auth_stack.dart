import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../login/login_screen.dart';
import '../register/register_screen.dart';

class AuthStack {
  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.login.path,
      name: AppRoutes.login.name,
      pageBuilder: (_, GoRouterState state) =>
          AppPage.fade(state, const LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.register.path,
      name: AppRoutes.register.name,
      builder: (_, _) => const RegisterScreen(),
    ),
  ];
}
