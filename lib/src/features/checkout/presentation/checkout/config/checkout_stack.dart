import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/presentation/order_success/order_success_screen.dart';

import '../checkout_screen.dart';

class CheckoutStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: CheckoutRoutes.checkout.path,
      name: CheckoutRoutes.checkout.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        final lines = state.uri.queryParameters['lines'];
        return CheckoutScreen(
          lineIds: lines == null || lines.isEmpty
              ? const {}
              : lines.split(',').toSet(),
        );
      },
    ),
    SdGoRouteV5(
      path: CheckoutRoutes.orderSuccess.path,
      name: CheckoutRoutes.orderSuccess.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return OrderSuccessScreen(
          orderId: state.uri.queryParameters['id'] ?? '',
        );
      },
    ),
  ];
}
