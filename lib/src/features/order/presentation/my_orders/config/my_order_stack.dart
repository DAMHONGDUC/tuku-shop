import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/presentation/order_detail/order_detail_screen.dart';

import '../my_orders_screen.dart';

/// Child routes of the Profile tab.
class MyOrderStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: MyOrderRoutes.myOrder.path,
      name: MyOrderRoutes.myOrder.name,
      builder: (BuildContext context, GoRouterState state) {
        final index = int.tryParse(state.uri.queryParameters['status'] ?? '');
        return MyOrdersScreen(
          initialStatus: index == null ? null : OrderStatusExt.fromIndex(index),
        );
      },
      routes: <RouteBase>[
        SdGoRouteV5(
          path: MyOrderRoutes.myOrderDetail.path,
          name: MyOrderRoutes.myOrderDetail.name,
          builder: (BuildContext context, GoRouterState state) {
            return OrderDetailScreen(
              orderId: state.uri.queryParameters['id'] ?? '',
            );
          },
        ),
      ],
    ),
  ];

  /// Routes above the tabs.
  static final List<GoRoute> rootRoutes = [
    SdGoRouteV5(
      path: MyOrderRoutes.orderDetail.path,
      name: MyOrderRoutes.orderDetail.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return OrderDetailScreen(
          orderId: state.uri.queryParameters['id'] ?? '',
        );
      },
    ),
  ];
}
