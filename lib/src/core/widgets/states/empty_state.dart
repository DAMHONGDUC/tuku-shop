import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// An empty list turned into guidance: an icon, what this place is for, and
/// one action to fill it.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SdSpacingV5.s32,
        vertical: SdSpacingV5.s48,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: colors.primarySoft,
              borderRadius: BorderRadius.circular(SdSpacingV5.s32),
            ),
            child: Center(
              child: SdIconV5(
                iconData: icon,
                iconSize: SdSpacingV5.s44,
                color: colors.primary,
              ),
            ),
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: SdTextStyleV5.heading16().wColor(colors.textDefault),
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
          ),
          if (actionLabel != null && onAction != null) ...[
            SdVerticalSpacingV5(value: SdSpacingV5.s24),
            AppButton(label: actionLabel!, onTap: onAction, expand: false),
          ],
        ],
      ),
    );
  }
}
