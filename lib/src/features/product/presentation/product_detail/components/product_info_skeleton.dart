import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/presentation/widgets/product_grid_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class ProductInfoSkeleton extends StatelessWidget {
  const ProductInfoSkeleton({super.key, required this.imgHeight});
  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SdSkeletonV5(height: imgHeight, borderRadius: BorderRadius.zero),
          Container(
            color: context.colorTheme.surfaceDefault,
            padding: EdgeInsets.all(SdSpacingV5.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // skeleton 1
                SdVerticalSpacingV5(),
                SdSkeletonV5(width: 300),
                SdVerticalSpacingV5(),
                SdSkeletonV5(width: 100),

                // skeleton 2
                SdVerticalSpacingV5(xRatio: 2),
                SdSkeletonV5(height: 80),

                // skeleton 3
                SdVerticalSpacingV5(xRatio: 2),
                SdSkeletonV5(),
                SdVerticalSpacingV5(),
                SdSkeletonV5(),
                SdVerticalSpacingV5(),
                SdSkeletonV5(),

                // skeleton 5
                SdVerticalSpacingV5(xRatio: 2),
                ProductGridSkeleton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
