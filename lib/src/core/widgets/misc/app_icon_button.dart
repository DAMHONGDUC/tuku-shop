import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

enum AppIconButtonStyle {
  /// Bare glyph, for app bars.
  plain,

  /// Translucent dark-grey disc with a white glyph, for buttons floating
  /// over photos (readable on light and dark pictures alike).
  floating,

  /// Card disc with a hairline, for docks and headers.
  outlined,
}

/// A 44 pt round icon button with an optional count badge.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.style = AppIconButtonStyle.plain,
    this.badgeCount = 0,
    this.iconColor,
  });

  final IconData icon;

  /// Read by screen readers; the button shows no text.
  final String label;
  final VoidCallback? onTap;
  final AppIconButtonStyle style;
  final int badgeCount;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final (fill, border, fg) = switch (style) {
      AppIconButtonStyle.plain => (
        SdColorsV5.transparent,
        BorderSide.none,
        colors.iconDefault,
      ),
      AppIconButtonStyle.floating => (
        AppColors.ink.withValues(alpha: 0.38),
        BorderSide.none,
        SdColorsV5.white,
      ),
      AppIconButtonStyle.outlined => (
        colors.surfaceDefault,
        BorderSide(color: colors.borderDefault),
        colors.iconDefault,
      ),
    };

    return Semantics(
      button: true,
      label: badgeCount > 0 ? '$label, $badgeCount' : label,
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: UIConstants.minTapTarget,
        child: Material(
          color: fill,
          shape: CircleBorder(side: border),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                SdIconV5(
                  iconData: icon,
                  iconSize: SdSpacingV5.s22,
                  color: iconColor ?? fg,
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: SdSpacingV5.s2,
                    top: SdSpacingV5.s4,
                    child: AnimatedSwitcher(
                      duration: UIConstants.navFast,
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: SdBadgeV5(
                        key: ValueKey(badgeCount),
                        count: badgeCount,
                        size: SdSpacingV5.s16,
                        badgeColor: colors.sale,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
