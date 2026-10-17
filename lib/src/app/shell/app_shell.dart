import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/cart_controller.dart';
import 'package:tuku_shop/src/app/state/wishlist_controller.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The five tabs under one floating bar.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onSelected(int index) {
    HapticFeedback.selectionClick();
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int bagCount = context.select<CartController, int>(
      (CartController c) => c.state.itemCount,
    );
    final int savedCount = context.select<WishlistController, int>(
      (WishlistController c) => c.state.length,
    );

    return SdScaffoldV5(
      extendBody: true,
      body: navigationShell,
      bottomBar: SdNavBarV5(
        selectedIndex: navigationShell.currentIndex,
        onSelected: _onSelected,
        destinations: <SdNavDestinationV5>[
          SdNavDestinationV5(icon: Symbols.home_rounded, label: context.loc.tab_home),
          SdNavDestinationV5(icon: Symbols.grid_view_rounded, label: context.loc.tab_shop),
          SdNavDestinationV5(
            icon: Symbols.favorite_rounded,
            label: context.loc.tab_wishlist,
            badgeCount: savedCount,
          ),
          SdNavDestinationV5(
            icon: Symbols.shopping_bag_rounded,
            label: context.loc.tab_bag,
            badgeCount: bagCount,
          ),
          SdNavDestinationV5(icon: Symbols.person_rounded, label: context.loc.tab_profile),
        ],
      ),
    );
  }
}

/// Holds every tab alive and cross-fades between them, rather than the
/// indexed stack's hard cut.
class FadingBranchContainer extends StatelessWidget {
  const FadingBranchContainer({
    required this.currentIndex,
    required this.children,
    super.key,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      for (final (int i, Widget child) in children.indexed)
        _Branch(active: i == currentIndex, child: child),
    ],
  );
}

class _Branch extends StatelessWidget {
  const _Branch({required this.active, required this.child});

  final bool active;
  final Widget child;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    ignoring: !active,
    child: TickerMode(
      enabled: active,
      child: AnimatedOpacity(
        opacity: active ? 1 : 0,
        duration: SdMotionV5.of(context, SdMotionV5.normal),
        curve: SdMotionV5.standard,
        child: AnimatedScale(
          scale: active ? 1 : 0.985,
          duration: SdMotionV5.of(context, SdMotionV5.normal),
          curve: SdMotionV5.standard,
          child: child,
        ),
      ),
    ),
  );
}

