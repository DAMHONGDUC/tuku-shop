import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class ListTitleSkeleton extends StatelessWidget {
  const ListTitleSkeleton({
    super.key,
    this.withAvatar = true,
    this.withTrailing = false,
  });

  final bool withAvatar;
  final bool withTrailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorTheme.cardDefault,
        borderRadius: BorderRadius.all(Radius.circular(SdSpacingV5.s12)),
      ),
      padding: EdgeInsets.all(SdSpacingV5.s12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (withAvatar) ...[
                SdSkeletonV5(
                  width: SdSpacingV5.s40,
                  height: SdSpacingV5.s40,
                  borderRadiusValue: SdSpacingV5.s100,
                ),
                SdHorizontalSpacingV5(),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SdSkeletonV5(width: 100),
                  SdVerticalSpacingV5(xRatio: 0.5),
                  SdSkeletonV5(width: 150),
                ],
              ),
            ],
          ),
          if (withTrailing) ...[
            SdSkeletonV5(
              width: SdSpacingV5.s20,
              height: SdSpacingV5.s20,
              borderRadiusValue: SdSpacingV5.s100,
            ),
          ],
        ],
      ),
    );
  }
}
