import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import '../product_detail_args.dart';
import '../product_detail_screen.dart';

class ProductStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: ProductRoutes.productDetail.path,
      name: ProductRoutes.productDetail.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        final args = state.extra as ProductDetailArgs;
        return ProductDetailScreen(args: args);
      },
    ),
  ];
}
