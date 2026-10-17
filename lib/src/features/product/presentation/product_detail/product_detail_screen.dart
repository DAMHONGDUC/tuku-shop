import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:system_design/index.dart';

import 'color_selection_section/color_selection_controller.dart';
import 'color_selection_section/color_selection_section.dart';
import 'components/bottom_action_section.dart';
import 'components/description_section.dart';
import 'components/product_info_skeleton.dart';
import 'components/product_introduce_section.dart';
import 'components/review_section.dart';
import 'product_detail_app_bar/product_detail_app_bar.dart';
import 'product_detail_app_bar/product_detail_app_bar_controller.dart';
import 'product_detail_args.dart';
import 'product_detail_controller.dart';
import 'related_product_section/related_products_controller.dart';
import 'related_product_section/related_products_section.dart';

final _kImgHeight = 400.0;

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailArgs args;

  const ProductDetailScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<ProductDetailController>()
                ..getProductDetail(productId: args.productId),
        ),
        BlocProvider(
          create: (_) =>
              getIt<RelatedProductsController>()
                ..getData(productId: args.productId),
        ),
        BlocProvider(create: (_) => getIt<ProductDetailAppBarController>()),
        BlocProvider(create: (_) => getIt<ColorSelectionController>()),
      ],
      child: _Body(args: args),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({required this.args});
  final ProductDetailArgs args;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      context.read<ProductDetailAppBarController>().setScrollOffset(
        _scrollController.offset,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future _onRefresh(BuildContext context) async {
    context.read<ProductDetailController>().getProductDetail(
      productId: widget.args.productId,
    );
    context.read<RelatedProductsController>().getData(
      productId: widget.args.productId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SdSafeAreaScaffoldV5(
      backgroundColor: context.colorTheme.surfaceDefault,
      bottomNavigationBar: _BottomSection(),
      child: BlocListener<ProductDetailController, ProductDetailState>(
        listener: (context, state) {
          if (state is ProductDetailLoadedState) {
            context.read<ColorSelectionController>().onChangeColor(
              state.product.productColors.firstOrNull,
            );
          } else if (state is ProductDetailErrorState) {
            // handle error case
          }
        },
        child: RefreshWrapper(
          onRefresh: () => _onRefresh(context),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Info section
              _ProductInfoSection(),

              // Related projects
              _SeperateSection(),
              SliverToBoxAdapter(child: RelatedProductsSection()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductInfoSection extends StatelessWidget {
  const _ProductInfoSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailController, ProductDetailState>(
      buildWhen: (previous, current) {
        return current is ProductDetailLoadingState ||
            current is ProductDetailLoadedState;
      },
      builder: (context, state) {
        if (state is ProductDetailLoadingState) {
          return MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: ProductInfoSkeleton(imgHeight: _kImgHeight),
              ),
            ],
          );
        } else if (state is ProductDetailLoadedState) {
          return MultiSliver(
            children: [
              // App Bar
              ProductDetailAppBar(
                product: state.product,
                imgHeight: _kImgHeight,
              ),

              // Product introduce section
              SliverToBoxAdapter(
                child: ProductIntroduceSection(product: state.product),
              ),

              // Color selection section
              if (state.product.productColors.isNotEmpty) ...[
                _SeperateSection(),
                SliverToBoxAdapter(
                  child: ColorSelectionSection(
                    productColors: state.product.productColors,
                  ),
                ),
              ],

              // Review section
              _SeperateSection(),
              SliverToBoxAdapter(child: ReviewSection(product: state.product)),

              // Description section
              if (state.product.description != null) ...[
                _SeperateSection(),
                SliverToBoxAdapter(
                  child: DescriptionSection(
                    description: state.product.description!,
                    imgHeight: _kImgHeight / 1.5,
                  ),
                ),
              ],
            ],
          );
        }
        return SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _BottomSection extends StatelessWidget {
  const _BottomSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailController, ProductDetailState>(
      buildWhen: (previous, current) {
        return current is ProductDetailLoadedState ||
            current is ProductDetailLoadingState;
      },
      builder: (context, state) {
        if (state is ProductDetailLoadedState) {
          return BottomActionSection(price: state.product.price);
        }
        return SizedBox.shrink();
      },
    );
  }
}

class _SeperateSection extends StatelessWidget {
  const _SeperateSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SdVerticalSpacingV5(
        bgColor: context.colorTheme.pageDefault,
        value: SdSpacingV5.s8,
      ),
    );
  }
}
