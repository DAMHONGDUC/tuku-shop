import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

import 'product_card.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceDefault,
        borderRadius: BorderRadius.circular(SdSpacingV5.s12),
        boxShadow: [
          BoxShadow(
            color: SdColorsV5.black12,
            blurRadius: SdSpacingV5.s12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          SdSkeletonV5(
            height: kImageSize,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SdSpacingV5.s8),
              topRight: Radius.circular(SdSpacingV5.s8),
            ),
          ),
          SizedBox(height: SdSpacingV5.s10),

          Container(
            padding: EdgeInsets.all(SdSpacingV5.s8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                SdSkeletonV5(width: double.infinity),
                SizedBox(height: SdSpacingV5.s4),

                // band
                SdSkeletonV5(width: 120),
                SizedBox(height: SdSpacingV5.s8),

                // price
                SdSkeletonV5(width: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
