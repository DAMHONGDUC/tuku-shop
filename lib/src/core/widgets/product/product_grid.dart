import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Height of a [ProductTile] at [width]: the 4:5 photo plus its three text
/// lines.
double productTileExtent(double width) =>
    width / UIConstants.productImageAspect + 86;

/// A two-column, non-scrolling grid of product tiles for use inside a parent
/// scroll view.
class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.trailingSkeletons = 0,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  /// Skeleton tiles appended while the next page loads.
  final int trailingSkeletons;

  static const double spacing = SdSpacingV5.s12;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = (constraints.maxWidth - spacing) / 2;
        return GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            mainAxisExtent: productTileExtent(tileWidth),
          ),
          itemCount: itemCount + trailingSkeletons,
          // Tiles fade up as they land; the stagger restarts per page.
          itemBuilder: (context, index) => index < itemCount
              ? FadeSlideIn(
                  index: index % 10,
                  child: itemBuilder(context, index),
                )
              : const ProductTileSkeleton(),
        );
      },
    );
  }
}
