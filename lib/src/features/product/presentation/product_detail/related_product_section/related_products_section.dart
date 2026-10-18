import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorite_product_tile.dart';

import 'related_products_controller.dart';

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key, required this.productId});

  final String productId;

  static const double _width = UIConstants.productStripCardWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
          child: Text(
            context.loc.pdp_related,
            style: SdTextStyleV5.heading16().wColor(
              context.colorTheme.textDefault,
            ),
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        BlocBuilder<RelatedProductsController, RelatedProductsState>(
          builder: (context, state) {
            if (state is RelatedProductsErrorState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
                child: SectionError(
                  onRetry: () => context
                      .read<RelatedProductsController>()
                      .getData(productId: productId),
                ),
              );
            }
            final products = state is RelatedProductsLoadedState
                ? state.products
                : null;
            return SizedBox(
              height: productTileExtent(_width),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
                scrollDirection: Axis.horizontal,
                itemCount: products?.length ?? 3,
                separatorBuilder: (_, _) =>
                    SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                itemBuilder: (context, index) => SizedBox(
                  width: _width,
                  child: products == null
                      ? const ProductTileSkeleton()
                      : FavoriteProductTile(product: products[index]),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
