import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The Cart tab.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.pageDefault,
      child: SafeArea(
        child: Center(
          child: EmptyState(
            icon: Icons.shopping_bag_outlined,
            title: context.loc.cart_empty_title,
            message: context.loc.cart_empty_message,
            actionLabel: context.loc.common_start_shopping,
            onAction: () => context.go(HomeRoutes.home.fullPath),
          ),
        ),
      ),
    );
  }
}
