import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../address_form/address_form_screen.dart';
import '../addresses/addresses_screen.dart';
import '../checkout/checkout_screen.dart';
import '../order_success/order_success_screen.dart';
import '../payment_methods/payment_methods_screen.dart';

class CheckoutStack {
  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.checkout.path,
      name: AppRoutes.checkout.name,
      builder: (_, _) => const CheckoutScreen(),
    ),
    GoRoute(
      path: AppRoutes.orderSuccess.path,
      name: AppRoutes.orderSuccess.name,
      pageBuilder: (_, GoRouterState state) => AppPage.rise(
        state,
        OrderSuccessScreen(orderId: state.pathParameters[AppRoutes.idParam]!),
      ),
    ),
    GoRoute(
      path: AppRoutes.addresses.path,
      name: AppRoutes.addresses.name,
      builder: (_, _) => const AddressesScreen(),
    ),
    GoRoute(
      path: AppRoutes.addressForm.path,
      name: AppRoutes.addressForm.name,
      builder: (_, GoRouterState state) => AddressFormScreen(
        args: state.extra is AddressFormArgs
            ? state.extra! as AddressFormArgs
            : null,
      ),
    ),
    GoRoute(
      path: AppRoutes.paymentMethods.path,
      name: AppRoutes.paymentMethods.name,
      builder: (_, _) => const PaymentMethodsScreen(),
    ),
  ];
}
