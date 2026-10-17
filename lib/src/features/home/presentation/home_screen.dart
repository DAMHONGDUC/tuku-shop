import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/banner/presentation/banner_carousel/banner_carousel.dart';
import 'package:tuku_shop/src/features/category/presentation/categories_section/categories_section.dart';
import 'package:tuku_shop/src/features/product/presentation/flash_sale/flash_sale_section.dart';
import 'package:tuku_shop/src/features/product/presentation/product_rail_section/product_rail_section.dart';
import 'package:tuku_shop/src/features/product/presentation/recommended/recommended_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/recommended/recommended_sliver.dart';

import 'components/home_header.dart';
import 'components/lookbook_section.dart';
import 'components/perks_strip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecommendedController _recommended = getIt<RecommendedController>()
    ..load();

  /// Bumped by pull-to-refresh; every section is keyed by it, so each one
  /// is rebuilt with a fresh controller and loads again.
  int _generation = 0;

  @override
  void dispose() {
    _recommended.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() => _generation++);
    await _recommended.load();
  }

  bool _onScroll(ScrollNotification n) {
    if (n.metrics.extentAfter < 600) _recommended.loadMore();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final double gap = SdContentPaddingV5.sectionGap;

    return BlocProvider<RecommendedController>.value(
      value: _recommended,
      child: SdScaffoldV5(
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: RefreshIndicator.adaptive(
            onRefresh: _refresh,
            color: context.sdTheme5.textPrimary,
            child: CustomScrollView(
              key: PageStorageKey<String>('home-$_generation'),
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: <Widget>[
                const SliverToBoxAdapter(child: HomeHeader()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: SdContentPaddingV5.gutter.copyWith(
                      top: SdSpacingConstant.h12,
                      bottom: SdSpacingConstant.h20,
                    ),
                    child: SdSearchFieldV5(
                      hint: context.loc.search_hint,
                      onTap: () => context.push(AppRoutes.search.path),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: BannerCarousel(key: ValueKey<int>(_generation)),
                ),
                SliverToBoxAdapter(child: SizedBox(height: gap * 0.75)),
                const SliverToBoxAdapter(child: PerksStrip()),
                SliverToBoxAdapter(child: SizedBox(height: gap)),
                SliverToBoxAdapter(
                  child: CategoriesSection(key: ValueKey<int>(_generation)),
                ),
                SliverToBoxAdapter(child: SizedBox(height: gap)),
                SliverToBoxAdapter(
                  child: FlashSaleSection(key: ValueKey<int>(_generation)),
                ),
                SliverToBoxAdapter(child: SizedBox(height: gap)),
                SliverToBoxAdapter(
                  child: ProductRailSection(
                    key: ValueKey<String>('new-$_generation'),
                    title: context.loc.home_new_arrivals,
                    subtitle: context.loc.home_new_arrivals_subtitle,
                    heroPrefix: 'new',
                    args: ProductListArgs(
                      title: context.loc.home_new_arrivals,
                      newOnly: true,
                      sort: ProductSort.newest,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: gap)),
                const SliverToBoxAdapter(child: LookbookSection()),
                SliverToBoxAdapter(child: SizedBox(height: gap)),
                SliverToBoxAdapter(
                  child: ProductRailSection(
                    key: ValueKey<String>('best-$_generation'),
                    title: context.loc.home_best_sellers,
                    heroPrefix: 'best',
                    args: ProductListArgs(
                      title: context.loc.home_best_sellers,
                      sort: ProductSort.bestSelling,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: gap)),
                const RecommendedSliver(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: SdContentPaddingV5.aboveNavBar(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
