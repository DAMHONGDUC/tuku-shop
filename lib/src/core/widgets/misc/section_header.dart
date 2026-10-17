import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final bool hasBottomSpacing;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
    this.hasBottomSpacing = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final showAction = onActionTap != null && (actionText ?? '').isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: hasBottomSpacing ? SdSpacingV5.s12 : 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: SdTextStyleV5.heading16().wColor(colors.textDefault),
            ),
          ),
          if (showAction)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onActionTap,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s4),
                child: Text(
                  actionText!,
                  style: SdTextStyleV5.body14().wSemiBold().wColor(
                    colors.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
