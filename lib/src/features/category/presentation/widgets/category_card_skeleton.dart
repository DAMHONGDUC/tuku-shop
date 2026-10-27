import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Placeholder for [CategoryCard]: the round photo and a short name line.
class CategoryCardSkeleton extends StatelessWidget {
  const CategoryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UIConstants.categoriesCardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SkeletonBox(
            width: UIConstants.categoriesImageWidth,
            height: UIConstants.categoriesImageHeight,
            radius: UIConstants.categoriesImageWidth / 2,
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s8),
          const SkeletonBox(width: 48, height: SdSpacingV5.s10),
        ],
      ),
    );
  }
}
