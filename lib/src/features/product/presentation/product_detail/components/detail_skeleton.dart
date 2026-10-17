import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

/// While the product loads: the hero's landing spot, then blocks where the
/// name, price and pickers will be.
class DetailSkeleton extends StatelessWidget {
  const DetailSkeleton({
    required this.heroTag,
    required this.galleryHeight,
    super.key,
  });

  final String heroTag;
  final double galleryHeight;

  @override
  Widget build(BuildContext context) => SdShimmerV5(
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(height: galleryHeight, child: const SdSkeletonV5()),
        Padding(
          padding: SdContentPaddingV5.gutter.copyWith(
            top: SdSpacingConstant.h20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SdSkeletonV5(
                width: SdSpacingConstant.w64 * 1.5,
                height: SdSpacingConstant.h12,
              ),
              SizedBox(height: SdSpacingConstant.h12),
              SdSkeletonV5(height: SdSpacingConstant.h28),
              SizedBox(height: SdSpacingConstant.h12),
              SdSkeletonV5(
                width: SdSpacingConstant.w200,
                height: SdSpacingConstant.h16,
              ),
              SizedBox(height: SdSpacingConstant.h20),
              SdSkeletonV5(
                width: SdSpacingConstant.w160,
                height: SdSpacingConstant.h24,
              ),
              SizedBox(height: SdSpacingConstant.h28),
              SdSkeletonV5(height: SdSpacingConstant.h48),
            ],
          ),
        ),
      ],
    ),
  );
}
