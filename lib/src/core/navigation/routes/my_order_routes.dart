import 'package:system_design/index.dart';

class MyOrderRoutes {
  static const SdRouterV5 myOrder = SdRouterV5(
    name: 'my-order',
    path: '/my-order',
    fullPath: '/my-order',
  );

  static final SdRouterV5 myOrderDetail = SdRouterV5(
    name: 'my-order-detail',
    path: 'my-order-detail',
    fullPath: '${myOrder.fullPath}/my-order-detail',
  );
}
