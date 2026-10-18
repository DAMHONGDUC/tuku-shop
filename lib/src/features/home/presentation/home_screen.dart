import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/banner/presentation/banner_carousel_section/banner_carousel_controller.dart';
import 'package:tuku_shop/src/features/banner/presentation/banner_carousel_section/banner_carousel_section.dart';
import 'package:tuku_shop/src/features/category/presentation/categories_section/categories_section.dart';
import 'package:tuku_shop/src/features/category/presentation/categories_section/categories_section_controller.dart';
import 'package:tuku_shop/src/features/notification/presentation/notification_badge/notification_badge_controller.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_grid_section.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_strip_section.dart';

import 'components/home_sliver_app_bar.dart';

/// Home: every section fires its own request and renders when it lands.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _banners = getIt<BannerCarouselController>();
  final _categories = getIt<CategoriesController>();
  final _flashSale = getIt<ProductListController>();
  final _newArrivals = getIt<ProductListController>();
  final _bestSellers = getIt<ProductListController>();
  final _forYou = getIt<ProductListController>();

  static const _stripSize = 8;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    _banners.getData();
    _categories.getData();
    _flashSale.load(const ProductQuery(onSaleOnly: true, pageSize: _stripSize));
    _newArrivals.load(
      const ProductQuery(tag: ProductTag.newArrival, pageSize: _stripSize),
    );
    _bestSellers.load(
      const ProductQuery(tag: ProductTag.bestSeller, pageSize: _stripSize),
    );
    await _forYou.load(const ProductQuery());
  }

  @override
  void dispose() {
    for (final c in [_flashSale, _newArrivals, _bestSellers, _forYou]) {
      c.close();
    }
    _banners.close();
    _categories.close();
    super.dispose();
  }

  void _openList(String title, {ProductTag? tag, bool onSale = false}) {
    context.push(
      ProductRoutes.productListLocation(
        title: title,
        tag: tag?.name,
        onSaleOnly: onSale,
      ),
    );
  }

  Widget _section({
    required String title,
    required Widget child,
    VoidCallback? onSeeAll,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: SdSpacingV5.s24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
            child: SectionHeader(
              title: title,
              actionText: onSeeAll == null ? '' : context.loc.common_see_all,
              onActionTap: onSeeAll,
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _strip(ProductListController controller) {
    return BlocProvider.value(
      value: controller,
      child: const Padding(
        padding: EdgeInsets.only(left: SdSpacingV5.s16),
        child: ProductStripSection(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    return ColoredBox(
      color: context.colorTheme.pageDefault,
      child: SafeArea(
        bottom: false,
        child: LoadMoreListener(
          onLoadMore: _forYou.loadMore,
          child: RefreshWrapper(
            onRefresh: _loadAll,
            child: CustomScrollView(
              slivers: [
                BlocBuilder<NotificationBadgeController, int>(
                  builder: (context, unread) =>
                      HomeSliverAppBar(unreadNotifications: unread),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SdSpacingV5.s16,
                        ),
                        child: BlocProvider.value(
                          value: _banners,
                          child: const BannerCarouselSection(),
                        ),
                      ),
                      _section(
                        title: loc.home_categories,
                        onSeeAll: () =>
                            context.go(CategoriesRoutes.categories.fullPath),
                        child: Padding(
                          padding: EdgeInsets.only(left: SdSpacingV5.s16),
                          child: BlocProvider.value(
                            value: _categories,
                            child: const CategoriesSection(),
                          ),
                        ),
                      ),
                      _section(
                        title: loc.home_flash_sale,
                        onSeeAll: () =>
                            _openList(loc.home_flash_sale, onSale: true),
                        child: _strip(_flashSale),
                      ),
                      _section(
                        title: loc.home_new_arrivals,
                        onSeeAll: () => _openList(
                          loc.home_new_arrivals,
                          tag: ProductTag.newArrival,
                        ),
                        child: _strip(_newArrivals),
                      ),
                      _section(
                        title: loc.home_best_sellers,
                        onSeeAll: () => _openList(
                          loc.home_best_sellers,
                          tag: ProductTag.bestSeller,
                        ),
                        child: _strip(_bestSellers),
                      ),
                      _section(
                        title: loc.home_just_for_you,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SdSpacingV5.s16,
                          ),
                          child: BlocProvider.value(
                            value: _forYou,
                            child: const ProductGridSection(),
                          ),
                        ),
                      ),
                      SizedBox(height: FloatingBottomNav.contentInset(context)),
                    ],
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
