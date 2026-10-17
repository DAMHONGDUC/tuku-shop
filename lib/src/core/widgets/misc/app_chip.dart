import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A pill used for sorts, sizes and suggestions.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.enabled = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onTap;
  final bool selected;

  /// A disabled chip stays visible, struck through (a sold-out size).
  final bool enabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final fg = selected
        ? SdColorsV5.white
        : enabled
        ? colors.textDefault
        : colors.textSubTitle.withValues(alpha: 0.6);

    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: UIConstants.navFast,
          constraints: const BoxConstraints(minWidth: SdSpacingV5.s44),
          padding: EdgeInsets.symmetric(
            horizontal: SdSpacingV5.s12,
            vertical: SdSpacingV5.s8,
          ),
          decoration: BoxDecoration(
            color: selected ? colors.primary : colors.cardDefault,
            borderRadius: BorderRadius.circular(SdSpacingV5.s100),
            border: Border.all(
              color: selected ? colors.primary : colors.borderDefault,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                SdIconV5(iconData: icon, iconSize: SdSpacingV5.s14, color: fg),
                SdHorizontalSpacingV5(value: SdSpacingV5.s4),
              ],
              Text(
                label,
                style:
                    (selected
                            ? SdTextStyleV5.body12().wSemiBold()
                            : SdTextStyleV5.body12())
                        .copyWith(
                          color: fg,
                          decoration: enabled
                              ? null
                              : TextDecoration.lineThrough,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
