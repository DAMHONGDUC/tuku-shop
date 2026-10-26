import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The cart's item count for every screen below it. The app root feeds it
/// from the cart, so core widgets show the badge without importing a feature.
class CartCountScope extends InheritedWidget {
  const CartCountScope({super.key, required this.count, required super.child});

  final int count;

  static int of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartCountScope>()?.count ?? 0;

  @override
  bool updateShouldNotify(CartCountScope oldWidget) => count != oldWidget.count;
}

/// The bag icon with its live count; opens the cart screen.
class CartActionButton extends StatelessWidget {
  const CartActionButton({super.key, this.style = AppIconButtonStyle.plain});

  final AppIconButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: Icons.shopping_bag_outlined,
      label: context.loc.cart_title,
      style: style,
      badgeCount: CartCountScope.of(context),
      onTap: () => context.push(CartRoutes.cart.fullPath),
    );
  }
}
