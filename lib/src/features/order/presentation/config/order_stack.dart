import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../order_detail/order_detail_screen.dart';
import '../orders/orders_screen.dart';

class OrderStack {
  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.orders.path,
      name: AppRoutes.orders.name,
      builder: (_, _) => const OrdersScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: ':${AppRoutes.idParam}',
          name: AppRoutes.orderDetail.name,
          builder: (_, GoRouterState state) => OrderDetailScreen(
            orderId: state.pathParameters[AppRoutes.idParam]!,
          ),
        ),
      ],
    ),
  ];
}
