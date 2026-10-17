import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../onboarding_screen.dart';

class OnboardingStack {
  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.onboarding.path,
      name: AppRoutes.onboarding.name,
      pageBuilder: (_, GoRouterState state) =>
          AppPage.fade(state, const OnboardingScreen()),
    ),
  ];
}
