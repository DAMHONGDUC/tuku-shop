import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/category_products/sort_chips.dart';

import 'search_filters_controller.dart';

/// Every way to narrow search results, edited as a draft and applied with
/// "Show results". Returns the new filters and sort, or null if dismissed.
class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key, required this.filters, required this.sort});

  final ProductFilters filters;
  final ProductSort sort;

  /// Ratings offered as "x★ & up".
  static const ratingSteps = [4.5, 4.0];

  static Future<(ProductFilters, ProductSort)?> show(
    BuildContext context, {
    required ProductFilters filters,
    required ProductSort sort,
  }) {
    return showModalBottomSheet<(ProductFilters, ProductSort)>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.colorTheme.surfaceDefault,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(UIConstants.sheetRadius),
        ),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<SearchFiltersController>(),
        child: FilterSheet(filters: filters, sort: sort),
      ),
    );
  }

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late ProductSort _sort = widget.sort;
  late String? _categoryId = widget.filters.categoryId;
  late ProductTag? _tag = widget.filters.tag;
  late bool _onSale = widget.filters.onSaleOnly;
  late bool _inStock = widget.filters.inStockOnly;
  late double? _minPrice = widget.filters.minPrice;
  late double? _maxPrice = widget.filters.maxPrice;
  late final Set<String> _sizes = {...widget.filters.sizes};
  late final Set<String> _colors = {...widget.filters.colors};
  late double? _minRating = widget.filters.minRating;

  void _reset() => setState(() {
    _sort = ProductSort.recommended;
    _categoryId = null;
    _tag = null;
    _onSale = false;
    _inStock = false;
    _minPrice = null;
    _maxPrice = null;
    _sizes.clear();
    _colors.clear();
    _minRating = null;
  });

  void _apply() {
    Navigator.of(context).pop((
      ProductFilters(
        categoryId: _categoryId,
        tag: _tag,
        onSaleOnly: _onSale,
        inStockOnly: _inStock,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        sizes: {..._sizes},
        colors: {..._colors},
        minRating: _minRating,
      ),
      _sort,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.85,
      child: Column(
        children: [
          SdVerticalSpacingV5(value: SdSpacingV5.s8),
          Container(
            width: SdSpacingV5.s36,
            height: SdSpacingV5.s4,
            decoration: BoxDecoration(
              color: colors.borderDefault,
              borderRadius: BorderRadius.circular(SdSpacingV5.s2),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              SdSpacingV5.s16,
              SdSpacingV5.s4,
              SdSpacingV5.s8,
              0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    loc.filter_title,
                    style: SdTextStyleV5.heading18()
                        .wColor(colors.textDefault)
                        .wDisplay(),
                  ),
                ),
                AppIconButton(
                  icon: Icons.close_rounded,
                  label: MaterialLocalizations.of(context).closeButtonTooltip,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchFiltersController, SearchFiltersState>(
              builder: (context, state) => switch (state.status) {
                SearchFiltersStatus.loading => ListView(
                  padding: EdgeInsets.all(SdSpacingV5.s16),
                  children: [
                    for (var i = 0; i < 5; i++) ...[
                      const SkeletonBox(width: 120),
                      SdVerticalSpacingV5(value: SdSpacingV5.s12),
                      const SkeletonBox(height: SdSpacingV5.s36),
                      SdVerticalSpacingV5(value: SdSpacingV5.s24),
                    ],
                  ],
                ),
                SearchFiltersStatus.error => Padding(
                  padding: EdgeInsets.all(SdSpacingV5.s16),
                  child: SectionError(
                    onRetry: context.read<SearchFiltersController>().load,
                  ),
                ),
                SearchFiltersStatus.loaded => _options(state),
              },
            ),
          ),
          BottomActionBar(
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: loc.filter_reset,
                    style: AppButtonStyle.soft,
                    onTap: _reset,
                  ),
                ),
                SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                Expanded(
                  child: AppButton(label: loc.filter_apply, onTap: _apply),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _options(SearchFiltersState state) {
    final loc = context.loc;
    final facets = state.facets!;
    final low = _minPrice ?? facets.minPrice;
    final high = _maxPrice ?? facets.maxPrice;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        SdSpacingV5.s16,
        SdSpacingV5.s8,
        SdSpacingV5.s16,
        SdSpacingV5.s16,
      ),
      children: [
        _Group(
          title: loc.filter_sort,
          child: _chips([
            for (final option in ProductSort.values)
              AppChip(
                label: SortChips.label(context, option),
                selected: _sort == option,
                onTap: () => setState(() => _sort = option),
              ),
          ]),
        ),
        _Group(
          title: loc.filter_category,
          child: _chips([
            AppChip(
              label: loc.filter_all,
              selected: _categoryId == null,
              onTap: () => setState(() => _categoryId = null),
            ),
            for (final category in state.categories)
              AppChip(
                label: category.name,
                selected: _categoryId == category.id,
                onTap: () => setState(() => _categoryId = category.id),
              ),
          ]),
        ),
        _Group(
          title: loc.filter_price,
          trailing: '${AppFormat.price(low)} – ${AppFormat.price(high)}',
          child: RangeSlider(
            min: facets.minPrice,
            max: facets.maxPrice,
            divisions: ((facets.maxPrice - facets.minPrice) / 5).ceil().clamp(
              1,
              1000,
            ),
            values: RangeValues(low, high),
            labels: RangeLabels(AppFormat.price(low), AppFormat.price(high)),
            onChanged: (range) => setState(() {
              // The full range is "no price filter".
              _minPrice = range.start <= facets.minPrice ? null : range.start;
              _maxPrice = range.end >= facets.maxPrice ? null : range.end;
            }),
          ),
        ),
        _Group(
          title: loc.filter_rating,
          child: _chips([
            AppChip(
              label: loc.filter_any,
              selected: _minRating == null,
              onTap: () => setState(() => _minRating = null),
            ),
            for (final step in FilterSheet.ratingSteps)
              AppChip(
                label: loc.filter_rating_up(step.toStringAsFixed(1)),
                selected: _minRating == step,
                onTap: () => setState(() => _minRating = step),
              ),
          ]),
        ),
        _Group(
          title: loc.filter_size,
          child: _chips([
            for (final size in facets.sizes)
              AppChip(
                label: size,
                selected: _sizes.contains(size),
                onTap: () => setState(
                  () => _sizes.contains(size)
                      ? _sizes.remove(size)
                      : _sizes.add(size),
                ),
              ),
          ]),
        ),
        _Group(
          title: loc.filter_color,
          child: _chips([
            for (final color in facets.colors)
              _ColorChip(
                color: color,
                selected: _colors.contains(color.name),
                onTap: () => setState(
                  () => _colors.contains(color.name)
                      ? _colors.remove(color.name)
                      : _colors.add(color.name),
                ),
              ),
          ]),
        ),
        _Group(
          title: loc.filter_more,
          child: _chips([
            AppChip(
              label: loc.filter_on_sale,
              icon: Icons.local_offer_outlined,
              selected: _onSale,
              onTap: () => setState(() => _onSale = !_onSale),
            ),
            AppChip(
              label: loc.filter_in_stock,
              icon: Icons.inventory_2_outlined,
              selected: _inStock,
              onTap: () => setState(() => _inStock = !_inStock),
            ),
            AppChip(
              label: loc.filter_new,
              selected: _tag == ProductTag.newArrival,
              onTap: () => setState(
                () => _tag = _tag == ProductTag.newArrival
                    ? null
                    : ProductTag.newArrival,
              ),
            ),
            AppChip(
              label: loc.filter_best_sellers,
              selected: _tag == ProductTag.bestSeller,
              onTap: () => setState(
                () => _tag = _tag == ProductTag.bestSeller
                    ? null
                    : ProductTag.bestSeller,
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _chips(List<Widget> chips) => Wrap(
    spacing: SdSpacingV5.s8,
    runSpacing: SdSpacingV5.s8,
    children: chips,
  );
}

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.child, this.trailing});

  final String title;
  final String? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: SdSpacingV5.s24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: SdTextStyleV5.heading16().wColor(colors.textDefault),
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: SdTextStyleV5.body14().copyWith(
                    color: colors.primary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
            ],
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s12),
          child,
        ],
      ),
    );
  }
}

/// A color name with its swatch; selected like an [AppChip].
class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final FacetColor color;
  final bool selected;
  final VoidCallback onTap;

  static Color _parse(String hex) {
    final digits = hex.replaceFirst('#', '');
    return Color(int.tryParse('FF$digits', radix: 16) ?? 0xFF9E9E9E);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Semantics(
      button: true,
      selected: selected,
      label: color.name,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: UIConstants.navFast,
          padding: EdgeInsets.fromLTRB(
            SdSpacingV5.s8,
            SdSpacingV5.s6,
            SdSpacingV5.s12,
            SdSpacingV5.s6,
          ),
          decoration: BoxDecoration(
            color: selected ? colors.primarySoft : colors.surfaceDefault,
            borderRadius: BorderRadius.circular(SdSpacingV5.s100),
            border: Border.all(
              color: selected ? colors.primary : colors.borderDefault,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: SdSpacingV5.s18,
                height: SdSpacingV5.s18,
                decoration: BoxDecoration(
                  color: _parse(color.hex),
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.borderDefault),
                ),
              ),
              SdHorizontalSpacingV5(value: SdSpacingV5.s6),
              Text(
                color.name,
                style: SdTextStyleV5.body12().wColor(colors.textDefault),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
