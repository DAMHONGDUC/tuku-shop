import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/home/presentation/home_screen.dart';
import 'package:tuku_shop/src/features/product/presentation/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import 'home_routes.dart';

class HomeStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: HomeRoutes.home.path,
      name: HomeRoutes.home.name,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        SdGoRouteV5(
          path: HomeRoutes.search.path,
          name: HomeRoutes.search.name,
          parentNavigatorKey: kRootNavigatorKey,
          builder: (BuildContext context, GoRouterState state) {
            return const SearchScreen();
          },
        ),
      ],
    ),
  ];
}
