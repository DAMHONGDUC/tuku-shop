import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';

import 'search_filters_controller.dart';

/// One-tap filters under the search bar (Shopee style): the category (tap
/// to change it in the full sheet), On sale, In stock, top rated, New and
/// Best sellers. Each tap applies at once.
class QuickFilterChips extends StatelessWidget {
  const QuickFilterChips({super.key, required this.onMore});

  /// Opens the full filter sheet.
  final VoidCallback onMore;

  static const double height = SdSpacingV5.s48;

  /// "4.5★ & up", the top rating step.
  static const _topRated = 4.5;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final colors = context.colorTheme;

    return BlocBuilder<ProductListController, ProductListState>(
      buildWhen: (a, b) => a.query != b.query,
      builder: (context, state) {
        final results = context.read<ProductListController>();
        final query = state.query;
        final f = query.filters;
        final categories = context
            .select<SearchFiltersController, Map<String, String>>(
              (c) => {for (final c in c.state.categories) c.id: c.name},
            );

        void apply(ProductFilters next) =>
            results.applyFilters(next, query.sort);

        ProductFilters copy({
          bool? onSale,
          bool? inStock,
          double? Function()? minRating,
          ProductTag? Function()? tag,
        }) => ProductFilters(
          categoryId: f.categoryId,
          tag: tag == null ? f.tag : tag(),
          onSaleOnly: onSale ?? f.onSaleOnly,
          inStockOnly: inStock ?? f.inStockOnly,
          minPrice: f.minPrice,
          maxPrice: f.maxPrice,
          sizes: f.sizes,
          colors: f.colors,
          minRating: minRating == null ? f.minRating : minRating(),
        );

        Widget gap() => SdHorizontalSpacingV5(value: SdSpacingV5.s8);
        final categoryName = f.categoryId == null
            ? null
            : categories[f.categoryId];

        return Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: colors.borderDefault)),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: SdSpacingV5.s16,
              vertical: SdSpacingV5.s6,
            ),
            children: [
              AppChip(
                label: categoryName ?? loc.filter_category,
                icon: Icons.category_outlined,
                selected: f.categoryId != null,
                onTap: onMore,
              ),
              gap(),
              AppChip(
                label: loc.filter_on_sale,
                icon: Icons.local_offer_outlined,
                selected: f.onSaleOnly,
                onTap: () => apply(copy(onSale: !f.onSaleOnly)),
              ),
              gap(),
              AppChip(
                label: loc.filter_in_stock,
                selected: f.inStockOnly,
                onTap: () => apply(copy(inStock: !f.inStockOnly)),
              ),
              gap(),
              AppChip(
                label: loc.filter_rating_up(_topRated.toStringAsFixed(1)),
                selected: f.minRating == _topRated,
                onTap: () => apply(
                  copy(
                    minRating: () =>
                        f.minRating == _topRated ? null : _topRated,
                  ),
                ),
              ),
              gap(),
              for (final (tag, label) in [
                (ProductTag.newArrival, loc.filter_new),
                (ProductTag.bestSeller, loc.filter_best_sellers),
              ]) ...[
                AppChip(
                  label: label,
                  selected: f.tag == tag,
                  onTap: () =>
                      apply(copy(tag: () => f.tag == tag ? null : tag)),
                ),
                gap(),
              ],
            ],
          ),
        );
      },
    );
  }
}
