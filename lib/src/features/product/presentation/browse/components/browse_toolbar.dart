import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../../filter/filter_sheet.dart';
import '../../filter/sort_sheet.dart';
import '../../widgets/product_labels.dart';
import '../product_browse_controller.dart';

/// Gender tabs, category chips, the result count, sort and filter — pinned
/// under the header while the grid scrolls.
class BrowseToolbarDelegate extends SliverPersistentHeaderDelegate {
  BrowseToolbarDelegate({
    required this.state,
    required this.showGenderTabs,
    required this.showCategories,
    required this.background,
  });

  final ProductBrowseState state;
  final bool showGenderTabs;
  final bool showCategories;
  final Color background;

  static double get _rowHeight => SdSpacingConstant.h48;

  double get _height =>
      _rowHeight * ((showGenderTabs ? 1 : 0) + (showCategories ? 1 : 0) + 1) +
      SdSpacingConstant.h12;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  bool shouldRebuild(BrowseToolbarDelegate old) =>
      old.state != state || old.background != background;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    final ProductBrowseController controller = context
        .read<ProductBrowseController>();
    final ProductQuery query = state.query;

    return ColoredBox(
      color: background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (showGenderTabs)
            SizedBox(
              height: _rowHeight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SdTabsV5(
                  labels: <String>[
                    for (final Gender g in <Gender>[
                      Gender.all,
                      Gender.women,
                      Gender.men,
                    ])
                      context.genderLabel(g),
                  ],
                  selectedIndex: <Gender>[
                    Gender.all,
                    Gender.women,
                    Gender.men,
                  ].indexOf(query.gender).clamp(0, 2),
                  onSelected: (int i) => controller.setGender(
                    <Gender>[Gender.all, Gender.women, Gender.men][i],
                  ),
                ),
              ),
            ),
          if (showCategories)
            SizedBox(
              height: _rowHeight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SdTabsV5(
                  labels: <String>[
                    context.loc.browse_all_categories,
                    for (final CategoryEntity c in state.categories) c.name,
                  ],
                  selectedIndex: query.categoryId == null
                      ? 0
                      : state.categories.indexWhere(
                              (CategoryEntity c) => c.id == query.categoryId,
                            ) +
                            1,
                  onSelected: (int i) => controller.setCategory(
                    i == 0 ? null : state.categories[i - 1].id,
                  ),
                ),
              ),
            ),
          SizedBox(
            height: _rowHeight,
            child: Padding(
              padding: SdContentPaddingV5.gutter,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: SdMotionV5.of(context, SdMotionV5.fast),
                      child: Text(
                        state.status == LoadStatus.loading
                            ? context.loc.browse_loading
                            : context.loc.browse_count(state.total),
                        key: ValueKey<String>('${state.status}-${state.total}'),
                        style: context.textTheme5.labelLarge!.muted5(context),
                      ),
                    ),
                  ),
                  SdButtonV5(
                    variant: SdButtonVariantV5.text,
                    size: SdButtonSizeV5.small,
                    icon: Symbols.swap_vert_rounded,
                    label: context.sortLabel(query.sort),
                    onPressed: () => showSortSheet(
                      context,
                      current: query.sort,
                      onSelected: controller.setSort,
                    ),
                  ),
                  SdIconButtonV5(
                    icon: Symbols.tune_rounded,
                    tooltip: context.loc.filter_title,
                    variant: query.activeFilterCount > 0
                        ? SdIconButtonVariantV5.filled
                        : SdIconButtonVariantV5.tonal,
                    size: SdSpacingConstant.r40,
                    badgeCount: query.activeFilterCount,
                    onPressed: () => showFilterSheet(
                      context,
                      query: query,
                      onApply: controller.applyFilters,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
