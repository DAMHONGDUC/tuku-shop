import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class CategoryCardSkeleton extends StatelessWidget {
  const CategoryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UIConstants.categoriesCardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SdSkeletonV5(
            height: UIConstants.categoriesImageHeight,
            width: UIConstants.categoriesImageWidth,
            borderRadiusValue: SdSpacingV5.s100,
          ),
          SdVerticalSpacingV5(),
          SdSkeletonV5(width: double.infinity),
        ],
      ),
    );
  }
}
