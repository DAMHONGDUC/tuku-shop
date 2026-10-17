import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../home_screen.dart';

class HomeStack {
  static final List<RouteBase> tabRoutes = <RouteBase>[
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.home.name,
      builder: (_, _) => const HomeScreen(),
    ),
  ];
}
