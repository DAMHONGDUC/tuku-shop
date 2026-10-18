import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorite_product_tile.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';

/// A horizontal row of products from the nearest [ProductListController].
class ProductStripSection extends StatelessWidget {
  const ProductStripSection({super.key});

  static const double _width = UIConstants.productStripCardWidth;

  @override
  Widget build(BuildContext context) {
    final height = productTileExtent(_width);

    return BlocBuilder<ProductListController, ProductListState>(
      builder: (context, state) {
        if (state.status == ProductListStatus.error) {
          return SectionError(
            onRetry: () => context.read<ProductListController>().refresh(),
          );
        }

        final loading =
            state.status == ProductListStatus.loading ||
            state.status == ProductListStatus.initial;

        if (state.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: loading ? 3 : state.items.length,
            separatorBuilder: (_, _) =>
                SdHorizontalSpacingV5(value: SdSpacingV5.s12),
            itemBuilder: (context, index) => SizedBox(
              width: _width,
              child: loading
                  ? const ProductTileSkeleton()
                  : FavoriteProductTile(product: state.items[index]),
            ),
          ),
        );
      },
    );
  }
}
