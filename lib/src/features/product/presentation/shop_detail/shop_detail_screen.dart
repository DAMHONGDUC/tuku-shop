import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/category_products/sort_chips.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_grid_section.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_strip_section.dart';

import 'categories/shop_categories_controller.dart';
import 'header/shop_header.dart';
import 'header/shop_header_controller.dart';

/// A shop's page, Shopee style: a cover with the shop, its stats, Follow
/// and Chat, then Shop (picks, new, on sale), Products (sortable, paged)
/// and Categories tabs. Every section loads on its own.
class ShopDetailScreen extends StatelessWidget {
  const ShopDetailScreen({super.key, required this.sellerId});

  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ShopHeaderController>()..load(sellerId),
        ),
        BlocProvider(
          create: (_) =>
              getIt<ProductListController>()
                ..load(ProductQuery(sellerId: sellerId)),
        ),
        BlocProvider(
          create: (_) => getIt<ShopCategoriesController>()..load(sellerId),
        ),
      ],
      child: _View(sellerId: sellerId),
    );
  }
}

class _View extends StatefulWidget {
  const _View({required this.sellerId});

  final String sellerId;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _scroll = ScrollController();

  /// True once the cover has scrolled under the app bar.
  final _collapsed = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scroll.addListener(
      () => _collapsed.value = _scroll.offset > ShopHeader.coverHeight - 24,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    _collapsed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return BlocListener<ShopHeaderController, ShopHeaderState>(
      listenWhen: (a, b) => b.failureCount > a.failureCount,
      listener: (context, _) => AppToast.of(
        context,
      ).show(loc.shop_follow_failed, type: AppToastType.error),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: colors.pageDefault,
          body: NestedScrollView(
            controller: _scroll,
            headerSliverBuilder: (context, _) => [
              ValueListenableBuilder<bool>(
                valueListenable: _collapsed,
                builder: (context, collapsed, _) => SliverAppBar(
                  pinned: true,
                  // Light status bar icons over the dark cover.
                  systemOverlayStyle: collapsed
                      ? null
                      : SystemUiOverlayStyle.light,
                  expandedHeight: ShopHeader.coverHeight,
                  backgroundColor: colors.pageDefault,
                  surfaceTintColor: SdColorsV5.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  centerTitle: true,
                  leading: Center(
                    child: AppIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      label: MaterialLocalizations.of(
                        context,
                      ).backButtonTooltip,
                      style: collapsed
                          ? AppIconButtonStyle.plain
                          : AppIconButtonStyle.floating,
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  title: collapsed
                      ? BlocSelector<
                          ShopHeaderController,
                          ShopHeaderState,
                          String
                        >(
                          selector: (s) => s.seller?.name ?? '',
                          builder: (context, name) => Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: SdTextStyleV5.heading16()
                                .wColor(colors.textDefault)
                                .wDisplay(),
                          ),
                        )
                      : null,
                  actionsPadding: EdgeInsets.only(right: SdSpacingV5.s8),
                  actions: [
                    CartActionButton(
                      style: collapsed
                          ? AppIconButtonStyle.plain
                          : AppIconButtonStyle.floating,
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: ShopHeader(sellerId: widget.sellerId),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabsHeader(
                  color: colors.pageDefault,
                  tabs: TabBar(
                    labelStyle: SdTextStyleV5.body14().wSemiBold(),
                    unselectedLabelStyle: SdTextStyleV5.body14(),
                    labelColor: colors.primary,
                    indicatorColor: colors.primary,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(text: loc.shop_tab_shop),
                      Tab(text: loc.shop_tab_products),
                      Tab(text: loc.shop_tab_categories),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: [
                _ShopTab(sellerId: widget.sellerId),
                const _ProductsTab(),
                _CategoriesTab(sellerId: widget.sellerId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabsHeader extends SliverPersistentHeaderDelegate {
  const _TabsHeader({required this.tabs, required this.color});

  final TabBar tabs;
  final Color color;

  @override
  double get minExtent => tabs.preferredSize.height;

  @override
  double get maxExtent => tabs.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) =>
      ColoredBox(color: color, child: tabs);

  @override
  bool shouldRebuild(_TabsHeader old) => old.color != color;
}

/// Picks, new arrivals and sale items from this shop; empty rows hide.
class _ShopTab extends StatelessWidget {
  const _ShopTab({required this.sellerId});

  final String sellerId;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final shopName = context.select<ShopHeaderController, String>(
      (c) => c.state.seller?.name ?? '',
    );

    return ListView(
      padding: EdgeInsets.only(
        top: SdSpacingV5.s8,
        bottom: BottomActionBar.bottomGap(context) + SdSpacingV5.s16,
      ),
      children: [
        _ShopStrip(
          title: loc.shop_top_picks,
          query: ProductQuery(
            sellerId: sellerId,
            sort: ProductSort.rating,
            pageSize: 8,
          ),
          seeAll: ProductRoutes.productListLocation(
            title: shopName,
            sellerId: sellerId,
          ),
        ),
        _ShopStrip(
          title: loc.home_new_arrivals,
          query: ProductQuery(
            sellerId: sellerId,
            tag: ProductTag.newArrival,
            pageSize: 8,
          ),
          seeAll: ProductRoutes.productListLocation(
            title: '$shopName · ${loc.home_new_arrivals}',
            sellerId: sellerId,
            tag: ProductTag.newArrival.name,
          ),
        ),
        _ShopStrip(
          title: loc.filter_on_sale,
          query: ProductQuery(
            sellerId: sellerId,
            onSaleOnly: true,
            pageSize: 8,
          ),
          seeAll: ProductRoutes.productListLocation(
            title: '$shopName · ${loc.filter_on_sale}',
            sellerId: sellerId,
            onSaleOnly: true,
          ),
        ),
      ],
    );
  }
}

class _ShopStrip extends StatelessWidget {
  const _ShopStrip({
    required this.title,
    required this.query,
    required this.seeAll,
  });

  final String title;
  final ProductQuery query;
  final String seeAll;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductListController>()..load(query),
      child: BlocBuilder<ProductListController, ProductListState>(
        buildWhen: (a, b) => a.isEmpty != b.isEmpty,
        builder: (context, state) {
          if (state.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: EdgeInsets.only(top: SdSpacingV5.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
                  child: SectionHeader(
                    title: title,
                    actionText: context.loc.common_see_all,
                    onActionTap: () => context.push(seeAll),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: SdSpacingV5.s16),
                  child: ProductStripSection(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Every listing of the shop, sortable, paged as you scroll.
class _ProductsTab extends StatelessWidget {
  const _ProductsTab();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProductListController>();

    return LoadMoreListener(
      onLoadMore: controller.loadMore,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocBuilder<ProductListController, ProductListState>(
              buildWhen: (a, b) =>
                  a.query != b.query || a.totalRecord != b.totalRecord,
              builder: (context, state) => Padding(
                padding: EdgeInsets.only(top: SdSpacingV5.s12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SortChips(
                      sort: state.query.sort,
                      onSaleOnly: state.query.onSaleOnly,
                      onSortChanged: controller.changeSort,
                      onSaleToggled: controller.toggleOnSaleOnly,
                    ),
                    Padding(
                      padding: EdgeInsets.all(SdSpacingV5.s16),
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
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              SdSpacingV5.s16,
              0,
              SdSpacingV5.s16,
              BottomActionBar.bottomGap(context) + SdSpacingV5.s16,
            ),
            sliver: const SliverToBoxAdapter(child: ProductGridSection()),
          ),
        ],
      ),
    );
  }
}

/// What the shop sells, by category; a row opens those listings.
class _CategoriesTab extends StatelessWidget {
  const _CategoriesTab({required this.sellerId});

  final String sellerId;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final shopName = context.select<ShopHeaderController, String>(
      (c) => c.state.seller?.name ?? '',
    );

    return BlocBuilder<ShopCategoriesController, ShopCategoriesState>(
      builder: (context, state) => switch (state.status) {
        ShopCategoriesStatus.loading => ListView(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          children: const [
            ListSkeleton(leading: ListSkeletonLeading.avatar, divided: true),
          ],
        ),
        ShopCategoriesStatus.error => ListView(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          children: [
            SectionError(
              onRetry: () =>
                  context.read<ShopCategoriesController>().load(sellerId),
            ),
          ],
        ),
        ShopCategoriesStatus.loaded => ListView.separated(
          padding: EdgeInsets.only(
            top: SdSpacingV5.s8,
            bottom: BottomActionBar.bottomGap(context) + SdSpacingV5.s16,
          ),
          itemCount: state.items.length,
          separatorBuilder: (_, _) => Divider(
            height: 1,
            indent: SdSpacingV5.s16 + SdSpacingV5.s48 + SdSpacingV5.s12,
            color: colors.borderDefault,
          ),
          itemBuilder: (context, i) {
            final (:category, :count) = state.items[i];
            return InkWell(
              onTap: () => context.push(
                ProductRoutes.productListLocation(
                  title: '$shopName · ${category.name}',
                  categoryId: category.id,
                  sellerId: sellerId,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SdSpacingV5.s16,
                  vertical: SdSpacingV5.s12,
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: SizedBox.square(
                        dimension: SdSpacingV5.s48,
                        child: CatalogImage(path: category.imageUrl),
                      ),
                    ),
                    SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: SdTextStyleV5.body14().wSemiBold().wColor(
                              colors.textDefault,
                            ),
                          ),
                          Text(
                            context.loc.products_count(count),
                            style: SdTextStyleV5.body12().wColor(
                              colors.textSubTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SdIconV5(
                      iconData: Icons.chevron_right_rounded,
                      iconSize: SdSpacingV5.s20,
                      color: colors.iconSecondary,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      },
    );
  }
}
