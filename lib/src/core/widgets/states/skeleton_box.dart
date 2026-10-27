import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A rounded placeholder with a soft light sweep. Every box takes its phase
/// from the clock, so all placeholders on a screen shimmer in step.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({
    super.key,
    this.width,
    this.height = SdSpacingV5.s14,
    this.radius = SdSpacingV5.s8,
    this.color,
  });

  final double? width;
  final double height;
  final double radius;

  /// Defaults to the theme surface; pass one for inverse (dark) cards.
  final Color? color;

  static const _period = Duration(milliseconds: 1400);

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sweep;

  @override
  void initState() {
    super.initState();
    final period = SkeletonBox._period.inMilliseconds;
    _sweep = AnimationController(vsync: this, duration: SkeletonBox._period)
      ..value = (DateTime.now().millisecondsSinceEpoch % period) / period
      ..repeat();
  }

  /// Without a [SkeletonBox.width], fill the parent's width like a
  /// `Container`, and collapse instead where the width is unbounded.
  static const _fill = LimitedBox(
    maxWidth: 0,
    maxHeight: 0,
    child: SizedBox.expand(),
  );

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    // A step darker than the card surface, so it reads on cards and page.
    final base =
        widget.color ??
        Color.lerp(
          context.colorTheme.cardOnSurface,
          dark ? SdColorsV5.white : AppColors.ink,
          dark ? 0.03 : 0.04,
        )!;
    // The highlight lifts the base a little: brighter in light mode,
    // a touch lighter in dark mode, never a hard white band.
    final highlight = Color.lerp(
      base,
      SdColorsV5.white,
      widget.color != null ? 0.12 : (dark ? 0.06 : 0.55),
    )!;
    final still = MediaQuery.disableAnimationsOf(context);

    return Semantics(
      excludeSemantics: true,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: still
            ? DecoratedBox(
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                child: _fill,
              )
            : AnimatedBuilder(
                animation: _sweep,
                builder: (context, _) {
                  // A band travelling from off the left edge to off the right.
                  final t = _sweep.value * 3 - 1;
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.radius),
                      gradient: LinearGradient(
                        begin: Alignment(-1 + t, -0.3),
                        end: Alignment(1 + t, 0.3),
                        colors: [base, highlight, base],
                        stops: const [0.25, 0.5, 0.75],
                      ),
                    ),
                    child: _fill,
                  );
                },
              ),
      ),
    );
  }
}
