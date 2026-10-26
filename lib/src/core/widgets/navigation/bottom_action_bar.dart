import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The bar pinned under a screen's content for its main actions (Add to
/// cart, Checkout, Place order). Its bottom gap is the safe area + 8, the
/// same on every screen.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.child});

  final Widget child;

  /// Gap under any bottom action: the home indicator area plus 8.
  static double bottomGap(BuildContext context) =>
      MediaQuery.viewPaddingOf(context).bottom + SdSpacingV5.s8;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceDefault,
        border: Border(top: BorderSide(color: colors.borderDefault)),
      ),
      padding: EdgeInsets.fromLTRB(
        SdSpacingV5.s16,
        SdSpacingV5.s12,
        SdSpacingV5.s16,
        bottomGap(context),
      ),
      child: child,
    );
  }
}
