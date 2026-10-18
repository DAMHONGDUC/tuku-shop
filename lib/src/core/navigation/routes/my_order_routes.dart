import 'package:system_design/index.dart';

/// My orders live under the Profile tab.
class MyOrderRoutes {
  static const SdRouterV5 myOrder = SdRouterV5(
    name: 'my-order',
    path: 'my-order',
    fullPath: '/profile/my-order',
  );

  static const SdRouterV5 myOrderDetail = SdRouterV5(
    name: 'my-order-detail',
    path: 'my-order-detail',
    fullPath: '/profile/my-order/my-order-detail',
  );

  /// [myOrderDetail] for one order.
  static String detailLocation(String orderId) => Uri(
    path: myOrderDetail.fullPath,
    queryParameters: {'id': orderId},
  ).toString();
}
