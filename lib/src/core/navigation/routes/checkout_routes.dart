import 'package:system_design/index.dart';

/// Checkout and its success screen, pushed above the tabs.
class CheckoutRoutes {
  static const SdRouterV5 checkout = SdRouterV5(
    name: 'checkout',
    path: '/checkout',
    fullPath: '/checkout',
  );

  static const SdRouterV5 orderSuccess = SdRouterV5(
    name: 'order-success',
    path: '/order-success',
    fullPath: '/order-success',
  );

  /// [checkout] for some cart lines only ("Buy now"); all lines when empty.
  static String checkoutLocation({Iterable<String> lineIds = const []}) => Uri(
    path: checkout.fullPath,
    queryParameters: lineIds.isEmpty ? null : {'lines': lineIds.join(',')},
  ).toString();

  /// [orderSuccess] for one order.
  static String orderSuccessLocation(String orderId) => Uri(
    path: orderSuccess.fullPath,
    queryParameters: {'id': orderId},
  ).toString();
}
