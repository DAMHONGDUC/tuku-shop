import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorite_product_tile.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';

/// A two-column grid for the nearest [ProductListController], for use inside
/// a parent scroll view that calls `loadMore` near its end.
class ProductGridSection extends StatelessWidget {
  const ProductGridSection({
    super.key,
    this.emptyTitle,
    this.emptyMessage,
    this.skeletonCount = 4,
  });

  final String? emptyTitle;
  final String? emptyMessage;
  final int skeletonCount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListController, ProductListState>(
      builder: (context, state) {
        final controller = context.read<ProductListController>();

        switch (state.status) {
          case ProductListStatus.initial:
          case ProductListStatus.loading:
            return ProductGrid(
              itemCount: 0,
              trailingSkeletons: skeletonCount,
              itemBuilder: (_, _) => const SizedBox.shrink(),
            );
          case ProductListStatus.error:
            return SectionError(onRetry: controller.refresh);
          case ProductListStatus.loaded:
            if (state.items.isEmpty) {
              return EmptyState(
                icon: Icons.checkroom_outlined,
                title: emptyTitle ?? context.loc.products_empty_title,
                message: emptyMessage ?? context.loc.products_empty_message,
              );
            }
            return Column(
              children: [
                ProductGrid(
                  itemCount: state.items.length,
                  trailingSkeletons: state.isLoadingMore ? 2 : 0,
                  itemBuilder: (context, index) =>
                      FavoriteProductTile(product: state.items[index]),
                ),
                if (state.loadMoreFailed) ...[
                  SdVerticalSpacingV5(value: SdSpacingV5.s12),
                  SectionError(onRetry: controller.loadMore),
                ],
              ],
            );
        }
      },
    );
  }
}
