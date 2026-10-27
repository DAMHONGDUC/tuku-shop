import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/category_products/sort_chips.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';

import 'filter_sheet.dart';
import 'search_filters_controller.dart';

/// One chip per [FilterSection] under the search bar (Shopee style). A tap
/// opens a small sheet with only that section; a chip in use is selected
/// and names what it is set to.
class QuickFilterChips extends StatelessWidget {
  const QuickFilterChips({super.key, required this.onOpen});

  /// Opens the filter sheet with only [section].
  final ValueChanged<FilterSection> onOpen;

  static const double height = SdSpacingV5.s48;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BlocBuilder<ProductListController, ProductListState>(
      buildWhen: (a, b) => a.query != b.query,
      builder: (context, state) {
        final query = state.query;
        final filtersState = context.watch<SearchFiltersController>().state;

        return Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: colors.borderDefault)),
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: SdSpacingV5.s16,
              vertical: SdSpacingV5.s6,
            ),
            itemCount: FilterSection.values.length,
            separatorBuilder: (_, _) =>
                SdHorizontalSpacingV5(value: SdSpacingV5.s8),
            itemBuilder: (context, i) {
              final section = FilterSection.values[i];
              final value = _value(context, section, query, filtersState);
              return AppChip(
                label: value ?? FilterSheet.title(context, section),
                trailingIcon: Icons.keyboard_arrow_down_rounded,
                selected: value != null,
                onTap: () => onOpen(section),
              );
            },
          ),
        );
      },
    );
  }

  /// What [section] is set to, or null when it narrows nothing.
  static String? _value(
    BuildContext context,
    FilterSection section,
    ProductQuery query,
    SearchFiltersState options,
  ) {
    final loc = context.loc;
    final f = query.filters;

    String? picked(String title, Set<String> values) => switch (values.length) {
      0 => null,
      1 => values.single,
      final n => '$title ($n)',
    };

    switch (section) {
      case FilterSection.sort:
        return query.sort == ProductSort.recommended
            ? null
            : SortChips.label(context, query.sort);
      case FilterSection.category:
        if (f.categoryId == null) return null;
        final match = options.categories.where((c) => c.id == f.categoryId);
        return match.isEmpty ? loc.filter_category : match.first.name;
      case FilterSection.price:
        if (f.minPrice == null && f.maxPrice == null) return null;
        final facets = options.facets;
        if (facets == null) return loc.filter_price;
        return '${AppFormat.price(f.minPrice ?? facets.minPrice)} – '
            '${AppFormat.price(f.maxPrice ?? facets.maxPrice)}';
      case FilterSection.rating:
        return f.minRating == null
            ? null
            : loc.filter_rating_up(f.minRating!.toStringAsFixed(1));
      case FilterSection.size:
        return picked(loc.filter_size, f.sizes);
      case FilterSection.color:
        return picked(loc.filter_color, f.colors);
      case FilterSection.more:
        final count = [
          f.onSaleOnly,
          f.inStockOnly,
          f.tag != null,
        ].where((on) => on).length;
        return count == 0 ? null : '${loc.filter_more} ($count)';
    }
  }
}
