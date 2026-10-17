import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SdListViewV5(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      items: List.generate(10, (e) => e),
      separatorBuilder: (context, index) {
        return SdVerticalSpacingV5();
      },
      itemBuilder: (_, index) {
        return ListTitleSkeleton(withAvatar: false, withTrailing: true);
      },
    );
  }
}
