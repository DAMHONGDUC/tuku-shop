import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A shimmering placeholder in the theme's surface color.
class SkeletonBox extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return SdSkeletonV5(
      width: width,
      height: height,
      borderRadiusValue: radius,
      color: color ?? context.colorTheme.cardOnSurface,
    );
  }
}
