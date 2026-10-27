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

/// Where [FlyToCart] lands: the button's rect on screen, and its bump.
typedef CartLanding = ({Rect rect, VoidCallback bump});

/// The bag icon with its live count; opens the cart screen. Bumps when a
/// product flies into it.
class CartActionButton extends StatefulWidget {
  const CartActionButton({super.key, this.style = AppIconButtonStyle.plain});

  final AppIconButtonStyle style;

  /// Mounted buttons, oldest first.
  static final _mounted = <_CartActionButtonState>[];

  /// The button on [context]'s screen, else the newest one; null when none
  /// is laid out.
  static CartLanding? landingFor(BuildContext context) {
    final route = ModalRoute.of(context);
    final button =
        _mounted.where((b) => b._route == route).lastOrNull ??
        _mounted.lastOrNull;
    final box = button?.context.findRenderObject();
    if (button == null || box is! RenderBox || !box.hasSize) return null;
    return (
      rect: box.localToGlobal(Offset.zero) & box.size,
      bump: button._bump,
    );
  }

  @override
  State<CartActionButton> createState() => _CartActionButtonState();
}

class _CartActionButtonState extends State<CartActionButton>
    with SingleTickerProviderStateMixin {
  late final _bumpController = AnimationController(
    vsync: this,
    duration: UIConstants.navNormal,
  );
  late final _scale = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 40),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.25,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.elasticOut)),
      weight: 60,
    ),
  ]).animate(_bumpController);

  ModalRoute<Object?>? _route;

  @override
  void initState() {
    super.initState();
    CartActionButton._mounted.add(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context);
  }

  @override
  void dispose() {
    CartActionButton._mounted.remove(this);
    _bumpController.dispose();
    super.dispose();
  }

  void _bump() {
    if (mounted) _bumpController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: AppIconButton(
        icon: Icons.shopping_bag_outlined,
        label: context.loc.cart_title,
        style: widget.style,
        badgeCount: CartCountScope.of(context),
        onTap: () => context.push(CartRoutes.cart.fullPath),
      ),
    );
  }
}
