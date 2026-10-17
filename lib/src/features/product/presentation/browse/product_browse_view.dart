import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../widgets/product_grid.dart';
import 'components/browse_toolbar.dart';
import 'product_browse_controller.dart';

/// The grid half of a browse screen as slivers under the screen's own
/// header: the pinned toolbar, the grid, the load-more row and the empty
/// state.
class ProductBrowseSlivers extends StatelessWidget {
  const ProductBrowseSlivers({
    required this.heroPrefix,
    this.showGenderTabs = true,
    this.showCategories = true,
    this.bottomInset = 0,
    super.key,
  });

  final String heroPrefix;
  final bool showGenderTabs;
  final bool showCategories;
  final double bottomInset;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductBrowseController, ProductBrowseState>(
        builder: (BuildContext context, ProductBrowseState state) => SliverMainAxisGroup(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: BrowseToolbarDelegate(
                state: state,
                showGenderTabs: showGenderTabs,
                showCategories: showCategories,
                background: context.sdTheme5.background,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: SdSpacingConstant.h8)),
            switch (state.status) {
              LoadStatus.loading => const ProductSliverGridSkeleton(count: 6),
              LoadStatus.failure => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorView(
                  onRetry: context.read<ProductBrowseController>().refresh,
                ),
              ),
              LoadStatus.success when state.products.isEmpty => SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: SdEmptyStateV5(
                    icon: Symbols.search_off_rounded,
                    title: context.loc.browse_empty_title,
                    message: context.loc.browse_empty_message,
                    action: state.query.activeFilterCount == 0
                        ? null
                        : SdButtonV5(
                            variant: SdButtonVariantV5.outlined,
                            label: context.loc.filter_clear,
                            onPressed: context
                                .read<ProductBrowseController>()
                                .clearFilters,
                          ),
                  ),
                ),
              ),
              LoadStatus.success => ProductSliverGrid(
                products: state.products,
                heroPrefix: heroPrefix,
              ),
            },
            if (state.loadingMore)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SdSpacingConstant.h20),
                  child: const SdLoadingV5(),
                ),
              ),
            if (state.status == LoadStatus.success &&
                !state.hasMore &&
                state.products.length > AppConstants.pageSize)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SdSpacingConstant.h24),
                  child: Text(
                    context.loc.browse_end(state.total),
                    textAlign: TextAlign.center,
                    style: context.textTheme5.labelMedium!.faint5(context),
                  ),
                ),
              ),
            SliverToBoxAdapter(child: SizedBox(height: bottomInset)),
          ],
        ),
      );
}

/// Calls `loadMore` as the grid nears its end.
class BrowseScrollListener extends StatelessWidget {
  const BrowseScrollListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollNotification>(
    onNotification: (ScrollNotification n) {
      if (n.metrics.axis == Axis.vertical && n.metrics.extentAfter < 500) {
        context.read<ProductBrowseController>().loadMore();
      }
      return false;
    },
    child: child,
  );
}
