import 'package:system_design/index.dart';

/// A shop's page, above the tabs; any feature can open it by seller id.
class ShopRoutes {
  static const SdRouterV5 shop = SdRouterV5(
    name: 'shop',
    path: '/shop',
    fullPath: '/shop',
  );

  static String shopLocation(String sellerId) =>
      Uri(path: shop.fullPath, queryParameters: {'id': sellerId}).toString();
}
