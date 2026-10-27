import 'package:flutter/material.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Fades its child in while it rises a few points, once, when first built.
/// [index] staggers siblings (capped, so long lists do not wait).
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({super.key, required this.child, this.index = 0});

  final Widget child;
  final int index;

  static const _step = Duration(milliseconds: 40);
  static const _maxStagger = 6;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _in = AnimationController(
    vsync: this,
    duration: UIConstants.navSlow,
  );
  late final Animation<double> _curve = CurvedAnimation(
    parent: _in,
    curve: Curves.easeOutCubic,
  );

  @override
  void initState() {
    super.initState();
    final delay =
        FadeSlideIn._step * widget.index.clamp(0, FadeSlideIn._maxStagger);
    Future<void>.delayed(delay, () {
      if (mounted) _in.forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) _in.value = 1;
  }

  @override
  void dispose() {
    _in.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curve,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).animate(_curve),
        child: widget.child,
      ),
    );
  }
}
