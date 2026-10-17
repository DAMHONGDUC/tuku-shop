import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'product_card.dart';

/// Two columns of [ProductCard]s as a sliver, each rising in turn.
class ProductSliverGrid extends StatelessWidget {
  const ProductSliverGrid({
    required this.products,
    required this.heroPrefix,
    super.key,
  });

  final List<ProductEntity> products;
  final String heroPrefix;

  static double cardWidth(BuildContext context) =>
      (MediaQuery.sizeOf(context).width -
          SdContentPaddingV5.horizontal * 2 -
          SdContentPaddingV5.gridGap) /
      2;

  static SliverGridDelegate delegate(BuildContext context) =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: SdContentPaddingV5.gridGap,
        mainAxisSpacing: SdSpacingConstant.h20,
        mainAxisExtent: ProductCard.heightFor(cardWidth(context)),
      );

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: SdContentPaddingV5.gutter,
    sliver: SliverGrid.builder(
      gridDelegate: delegate(context),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int i) => SdFadeInV5(
        index: i % AppConstants.pageSize,
        child: ProductCard(
          product: products[i],
          heroTag: '$heroPrefix-${products[i].id}',
        ),
      ),
    ),
  );
}

/// The grid's loading state: the same layout in skeleton blocks.
class ProductSliverGridSkeleton extends StatelessWidget {
  const ProductSliverGridSkeleton({this.count = 4, super.key});

  final int count;

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: SdContentPaddingV5.gutter,
    sliver: SliverGrid.builder(
      gridDelegate: ProductSliverGrid.delegate(context),
      itemCount: count,
      itemBuilder: (_, _) => const SdShimmerV5(child: ProductCardSkeleton()),
    ),
  );
}

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const AspectRatio(
        aspectRatio: ProductCard.imageAspect,
        child: SdSkeletonV5(),
      ),
      SizedBox(height: SdSpacingConstant.h12),
      SdSkeletonV5(width: SdSpacingConstant.w64, height: SdSpacingConstant.h10),
      SizedBox(height: SdSpacingConstant.h8),
      SdSkeletonV5(height: SdSpacingConstant.h14),
      SizedBox(height: SdSpacingConstant.h8),
      SdSkeletonV5(
        width: SdSpacingConstant.w64 * 1.3,
        height: SdSpacingConstant.h14,
      ),
    ],
  );
}
