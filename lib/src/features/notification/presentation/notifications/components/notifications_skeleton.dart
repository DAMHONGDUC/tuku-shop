import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Card-shaped placeholders while the list loads.
class NotificationsSkeleton extends StatelessWidget {
  const NotificationsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return ListView.separated(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      separatorBuilder: (_, _) => SdVerticalSpacingV5(value: SdSpacingV5.s8),
      itemBuilder: (_, _) => Container(
        padding: EdgeInsets.all(SdSpacingV5.s16),
        decoration: BoxDecoration(
          color: colors.cardDefault,
          borderRadius: BorderRadius.circular(UIConstants.cardRadius),
        ),
        child: Row(
          children: [
            const SkeletonBox(
              width: SdSpacingV5.s44,
              height: SdSpacingV5.s44,
              radius: SdSpacingV5.s100,
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 160),
                  SizedBox(height: SdSpacingV5.s8),
                  SkeletonBox(height: SdSpacingV5.s12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
