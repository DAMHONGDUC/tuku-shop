import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import '../tutorial_screen.dart';
import 'package:tuku_shop/src/core/navigation/routes/tutorial_routes.dart';

class TutorialStack {
  static final routes = [
    SdGoRouteV5(
      path: TutorialRoutes.tutorial.path,
      name: TutorialRoutes.tutorial.name,
      builder: (BuildContext context, GoRouterState state) {
        return const TutorialScreen();
      },
    ),
  ];
}
