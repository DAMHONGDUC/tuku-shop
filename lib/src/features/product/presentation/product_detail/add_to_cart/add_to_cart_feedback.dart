import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import 'add_to_cart_controller.dart';

/// What happens after an add: Buy now goes to checkout, Add to cart shows a
/// toast with "View cart", a failure shows an error toast. Shared by the
/// product page and its reviews screen.
class AddToCartFeedback extends StatelessWidget {
  const AddToCartFeedback({super.key, required this.child});

  final Widget child;

  static void _onAddToCart(BuildContext context, AddToCartState state) {
    final toast = AppToast.of(context);
    switch (state.status) {
      case AddToCartStatus.added when state.buyNow:
        context.push(CheckoutRoutes.checkoutLocation(lineIds: [state.lineId!]));
      case AddToCartStatus.added:
        toast.show(
          context.loc.pdp_added_to_cart,
          type: AppToastType.success,
          actionLabel: context.loc.pdp_view_cart,
          onAction: () => context.push(CartRoutes.cart.fullPath),
        );
      case AddToCartStatus.failed:
        toast.show(context.loc.pdp_add_failed, type: AppToastType.error);
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartController, AddToCartState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: _onAddToCart,
      child: child,
    );
  }
}
