import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/presentation/cart/cart_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorites_controller.dart';

/// The five tabs under the floating V5 bar.
class BottomTabBaseScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomTabBaseScreen({super.key, required this.navigationShell});

  void _onSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final wishlistCount = context.select<FavoritesController, int>(
      (c) => c.state.ids.length,
    );
    final cartCount = context.select<CartController, int>(
      (c) => c.state.itemCount,
    );

    return FloatingBottomNav(
      body: navigationShell,
      selectedIndex: navigationShell.currentIndex,
      onSelected: _onSelected,
      destinations: [
        FloatingNavDestination(
          icon: Icons.home_outlined,
          selectedIcon: Icons.home_rounded,
          label: loc.nav_home,
        ),
        FloatingNavDestination(
          icon: Icons.grid_view_outlined,
          selectedIcon: Icons.grid_view_rounded,
          label: loc.nav_categories,
        ),
        FloatingNavDestination(
          icon: Icons.favorite_border_rounded,
          selectedIcon: Icons.favorite_rounded,
          label: loc.nav_wishlist,
          badgeCount: wishlistCount,
        ),
        FloatingNavDestination(
          icon: Icons.shopping_bag_outlined,
          selectedIcon: Icons.shopping_bag_rounded,
          label: loc.nav_cart,
          badgeCount: cartCount,
        ),
        FloatingNavDestination(
          icon: Icons.person_outline_rounded,
          selectedIcon: Icons.person_rounded,
          label: loc.nav_profile,
        ),
      ],
    );
  }
}
