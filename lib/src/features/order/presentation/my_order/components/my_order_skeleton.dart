import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class MyOrderSkeleton extends StatelessWidget {
  const MyOrderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SdListViewV5(
      padding: EdgeInsets.all(SdSpacingV5.s10),
      itemBuilder: (context, index) {
        return _MyOrderCardSkeleton();
      },
      separatorBuilder: (_, __) => SdVerticalSpacingV5(value: SdSpacingV5.s10),
      items: List.generate(10, (e) => e),
    );
  }
}

class _MyOrderCardSkeleton extends StatelessWidget {
  const _MyOrderCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorTheme.cardDefault,
        borderRadius: BorderRadius.all(Radius.circular(SdSpacingV5.s10)),
      ),
      padding: EdgeInsets.all(SdSpacingV5.s12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SdSkeletonV5(width: 60, height: 60),
          SdHorizontalSpacingV5(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SdSkeletonV5(width: 50),
              SdVerticalSpacingV5(xRatio: 0.5),
              SdSkeletonV5(width: 100),
              SdVerticalSpacingV5(xRatio: 0.5),
              SdSkeletonV5(width: 200),
            ],
          ),
        ],
      ),
    );
  }
}
