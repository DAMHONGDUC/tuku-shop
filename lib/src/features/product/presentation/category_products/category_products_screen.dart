import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_grid_section.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';

import 'category_products_args.dart';
import 'sort_chips.dart';

/// Products of one category (or tag), sortable and paged.
class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key, required this.args});

  final CategoryProductsArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductListController>()..load(args.query),
      child: _View(title: args.title, showSaleChip: !args.onSaleOnly),
    );
  }
}

class _View extends StatelessWidget {
  const _View({required this.title, required this.showSaleChip});

  final String title;
  final bool showSaleChip;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProductListController>();

    return Scaffold(
      backgroundColor: context.colorTheme.pageDefault,
      appBar: AppTopBar(title: title),
      body: LoadMoreListener(
        onLoadMore: controller.loadMore,
        child: RefreshWrapper(
          onRefresh: controller.refresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlocBuilder<ProductListController, ProductListState>(
                  buildWhen: (a, b) =>
                      a.query != b.query || a.totalRecord != b.totalRecord,
                  builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SdVerticalSpacingV5(value: SdSpacingV5.s8),
                      SortChips(
                        sort: state.query.sort,
                        onSaleOnly: state.query.onSaleOnly,
                        showSaleChip: showSaleChip,
                        onSortChanged: controller.changeSort,
                        onSaleToggled: controller.toggleOnSaleOnly,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          SdSpacingV5.s16,
                          SdSpacingV5.s12,
                          SdSpacingV5.s16,
                          SdSpacingV5.s12,
                        ),
                        child: Text(
                          state.status == ProductListStatus.loaded
                              ? context.loc.products_count(state.totalRecord)
                              : ' ',
                          style: SdTextStyleV5.body12().wColor(
                            context.colorTheme.textSubTitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s16,
                  0,
                  SdSpacingV5.s16,
                  SdSpacingV5.s32 + MediaQuery.paddingOf(context).bottom,
                ),
                sliver: const SliverToBoxAdapter(child: ProductGridSection()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
