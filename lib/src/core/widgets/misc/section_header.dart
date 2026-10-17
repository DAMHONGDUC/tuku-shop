import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart' hide SdContextV2X;

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.textTheme.heading16),
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText ?? 'See All',
                style: context.textTheme.heading12.wColor(AppColors.primary),
              ),
            ),
          ],
        ),
        if (hasBottomSpacing) SdVerticalSpacingV5(),
      ],
    );
  }
}
