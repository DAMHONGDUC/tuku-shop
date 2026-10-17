import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/banner/presentation/banner_carousel_section/banner_carousel_controller.dart';
import 'package:tuku_shop/src/features/banner/presentation/banner_carousel_section/banner_carousel_section.dart';
import 'package:tuku_shop/src/features/category/presentation/categories_section/categories_section.dart';
import 'package:tuku_shop/src/features/category/presentation/categories_section/categories_section_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/recommend_products_section/recommend_products_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/recommend_products_section/recommend_products_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';

import 'components/home_sliver_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<BannerCarouselController>()..getData(),
        ),
        BlocProvider(create: (_) => getIt<CategoriesController>()..getData()),
        BlocProvider(
          create: (_) => getIt<RecommendProductsController>()..onRefresh(),
        ),
      ],
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<RecommendProductsController>().onLoadMore();
    }
  }

  Future _onRefreshHome(BuildContext context) async {
    context.read<BannerCarouselController>().getData();
    context.read<CategoriesController>().getData();
    context.read<RecommendProductsController>().onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return SdSafeAreaScaffoldV5(
      backgroundColor: context.colorTheme.surfaceDefault,
      contentBgColor: context.colorTheme.pageDefault,
      child: RefreshWrapper(
        onRefresh: () => _onRefreshHome(context),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            // app bar
            HomeSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // banner
                  SectionContainer(
                    topMargin: true,
                    bottomMargin: true,
                    child: const BannerCarouselSection(),
                  ),

                  // category
                  SectionContainer(
                    titleWidget: const SectionHeader(title: 'Categories'),
                    bottomMargin: true,
                    child: const CategoriesSection(),
                  ),

                  // product
                  SectionContainer(
                    titleWidget: const SectionHeader(title: 'New Arrivals 🔥'),
                    child: RecommendProductsSection(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
