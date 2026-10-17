import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'product_card.dart';
import 'product_grid.dart';

/// A horizontal strip of product cards.
class ProductRail extends StatelessWidget {
  const ProductRail({
    required this.products,
    required this.heroPrefix,
    super.key,
  });

  final List<ProductEntity> products;
  final String heroPrefix;

  static double cardWidth(BuildContext context) =>
      ProductSliverGrid.cardWidth(context) * 0.92;

  static double height(BuildContext context) =>
      ProductCard.heightFor(cardWidth(context));

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height(context),
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: SdContentPaddingV5.gutter,
      itemCount: products.length,
      separatorBuilder: (_, _) => SizedBox(width: SdContentPaddingV5.gridGap),
      itemBuilder: (BuildContext context, int i) => SizedBox(
        width: cardWidth(context),
        child: SdFadeInV5(
          index: i,
          child: ProductCard(
            product: products[i],
            heroTag: '$heroPrefix-${products[i].id}',
          ),
        ),
      ),
    ),
  );
}

class ProductRailSkeleton extends StatelessWidget {
  const ProductRailSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: ProductRail.height(context),
    child: SdShimmerV5(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: SdContentPaddingV5.gutter,
        itemCount: 3,
        separatorBuilder: (_, _) => SizedBox(width: SdContentPaddingV5.gridGap),
        itemBuilder: (BuildContext context, int _) => SizedBox(
          width: ProductRail.cardWidth(context),
          child: const ProductCardSkeleton(),
        ),
      ),
    ),
  );
}
