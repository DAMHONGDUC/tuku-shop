import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

enum AppButtonStyle { primary, soft }

/// The app's one button shape: 48 pt tall, radius 14, brand fill or a 6 %
/// brand tint for the secondary action.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.style = AppButtonStyle.primary,
    this.expand = true,
    this.isLoading = false,
    this.leadingIcon,
  });

  final String label;
  final VoidCallback? onTap;
  final AppButtonStyle style;
  final bool expand;
  final bool isLoading;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final enabled = onTap != null && !isLoading;
    final isPrimary = style == AppButtonStyle.primary;
    final fg = isPrimary ? SdColorsV5.white : colors.primary;
    final bg = isPrimary ? colors.primary : colors.primarySoft;

    final content = isLoading
        ? SizedBox(
            width: SdSpacingV5.s20,
            height: SdSpacingV5.s20,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                SdIconV5(
                  iconData: leadingIcon,
                  iconSize: SdSpacingV5.s18,
                  color: fg,
                ),
                SdHorizontalSpacingV5(value: SdSpacingV5.s8),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: SdTextStyleV5.body14().wSemiBold().wColor(fg),
                ),
              ),
            ],
          );

    return Opacity(
      opacity: enabled || isLoading ? 1 : 0.5,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: SdSpacingV5.s48,
            width: expand ? double.infinity : null,
            padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s24),
            decoration: isPrimary
                ? null
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.12),
                    ),
                  ),
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }
}
