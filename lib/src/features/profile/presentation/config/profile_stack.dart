import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../edit_profile/edit_profile_screen.dart';
import '../help_center/help_center_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';

class ProfileStack {
  static final List<RouteBase> tabRoutes = <RouteBase>[
    GoRoute(
      path: AppRoutes.profile.path,
      name: AppRoutes.profile.name,
      builder: (_, _) => const ProfileScreen(),
    ),
  ];

  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.editProfile.path,
      name: AppRoutes.editProfile.name,
      builder: (_, _) => const EditProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings.path,
      name: AppRoutes.settings.name,
      builder: (_, _) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.helpCenter.path,
      name: AppRoutes.helpCenter.name,
      builder: (_, _) => const HelpCenterScreen(),
    ),
  ];
}
