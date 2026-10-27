import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Card-shaped placeholders while the list loads: five, left-aligned.
class NotificationsSkeleton extends StatelessWidget {
  const NotificationsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ListSkeleton(leading: ListSkeletonLeading.avatar, card: true),
      ],
    );
  }
}
