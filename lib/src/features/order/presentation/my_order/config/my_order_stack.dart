import 'package:tuku_shop/src/features/order/presentation/my_order/my_order_detail/my_order_detail.dart';
import 'package:tuku_shop/src/features/order/presentation/my_order/my_order_detail/my_order_detail_args.dart';
import 'package:tuku_shop/src/features/order/presentation/my_order/my_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import 'package:tuku_shop/src/core/navigation/routes/my_order_routes.dart';

class MyOrderStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: MyOrderRoutes.myOrder.path,
      name: MyOrderRoutes.myOrder.name,
      builder: (BuildContext context, GoRouterState state) {
        return const MyOrderScreen();
      },
      routes: <RouteBase>[
        SdGoRouteV5(
          path: MyOrderRoutes.myOrderDetail.path,
          name: MyOrderRoutes.myOrderDetail.name,
          builder: (BuildContext context, GoRouterState state) {
            final args = state.extra as MyOrderDetailArgs;
            return MyOrderDetailScreen(args: args);
          },
        ),
      ],
    ),
  ];
}
