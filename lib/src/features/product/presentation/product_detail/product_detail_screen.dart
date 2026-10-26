import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'add_to_cart/add_to_cart_controller.dart';
import 'add_to_cart/add_to_cart_feedback.dart';
import 'components/product_action_dock.dart';
import 'components/product_gallery.dart';
import 'components/product_info_section.dart';
import 'product_detail_args.dart';
import 'product_detail_controller.dart';
import 'related_product_section/related_products_controller.dart';
import 'related_product_section/related_products_section.dart';
import 'reviews_section/product_reviews_controller.dart';
import 'reviews_section/reviews_section.dart';
import 'variant_section/variant_section.dart';
import 'variant_section/variant_selection_controller.dart';

/// The product page. Header, reviews and related items are three requests
/// that fill in independently.
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.args});

  final ProductDetailArgs args;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<ProductDetailController>()
                ..getProductDetail(productId: args.productId),
        ),
        BlocProvider(create: (_) => getIt<VariantSelectionController>()),
        BlocProvider(create: (_) => getIt<AddToCartController>()),
        BlocProvider(
          create: (_) => getIt<ProductReviewsController>()
            ..load(
              args.productId,
              pageSize: ProductReviewsController.previewSize,
            ),
        ),
        BlocProvider(
          create: (_) =>
              getIt<RelatedProductsController>()
                ..getData(productId: args.productId),
        ),
      ],
      child: _View(productId: args.productId),
    );
  }
}

class _View extends StatefulWidget {
  const _View({required this.productId});

  final String productId;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _scrollController = ScrollController();

  /// True once the gallery has scrolled under the app bar.
  final _collapsed = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final galleryHeight = _Content.galleryHeight(context);
      _collapsed.value =
          _scrollController.offset >
          galleryHeight - kToolbarHeight - MediaQuery.paddingOf(context).top;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _collapsed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final productId = widget.productId;

    return AddToCartFeedback(
      child: BlocConsumer<ProductDetailController, ProductDetailState>(
        listener: (context, state) {
          if (state is ProductDetailLoadedState) {
            context.read<VariantSelectionController>().init(state.product);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: colors.pageDefault,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ValueListenableBuilder<bool>(
                valueListenable: _collapsed,
                builder: (context, collapsed, _) => AppBar(
                  backgroundColor: collapsed
                      ? colors.pageDefault
                      : SdColorsV5.transparent,
                  surfaceTintColor: SdColorsV5.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  centerTitle: true,
                  title: collapsed && state is ProductDetailLoadedState
                      ? Text(
                          state.product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: SdTextStyleV5.heading16()
                              .wColor(colors.textDefault)
                              .wDisplay(),
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
                  // Same button style as the cart action, so the pair match
                  // over the photo and in the collapsed bar.
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
                ),
              ),
            ),
            bottomNavigationBar: state is ProductDetailLoadedState
                ? ProductActionDock(product: state.product)
                : null,
            body: switch (state) {
              ProductDetailLoadedState(:final product) => _Content(
                product: product,
                controller: _scrollController,
              ),
              ProductDetailErrorState() => SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(SdSpacingV5.s16),
                  child: Center(
                    child: SectionError(
                      onRetry: () => context
                          .read<ProductDetailController>()
                          .getProductDetail(productId: productId),
                    ),
                  ),
                ),
              ),
              _ => const _Skeleton(),
            },
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.product, required this.controller});

  final ProductEntity product;
  final ScrollController controller;

  static double galleryHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).width / UIConstants.productImageAspect * 0.92;

  @override
  Widget build(BuildContext context) {
    final card = BoxDecoration(
      color: context.colorTheme.cardDefault,
      borderRadius: BorderRadius.circular(UIConstants.cardRadius),
    );
    final pad = EdgeInsets.all(SdSpacingV5.s16);

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: galleryHeight(context),
            child: ProductGallery(product: product),
          ),
        ),
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: const Offset(0, -SdSpacingV5.s16),
            child: Container(
              decoration: BoxDecoration(
                color: context.colorTheme.pageDefault,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(UIConstants.sheetRadius),
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                SdSpacingV5.s16,
                SdSpacingV5.s24,
                SdSpacingV5.s16,
                SdSpacingV5.s16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProductInfoSection(product: product),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  Container(
                    decoration: card,
                    padding: pad,
                    child: VariantSection(product: product),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  const TrustRow(),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  Container(
                    decoration: card,
                    padding: pad,
                    child: DetailsSection(product: product),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  Container(
                    decoration: card,
                    padding: pad,
                    child: ReviewsSection(product: product),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: RelatedProductsSection(productId: product.id),
        ),
        SliverToBoxAdapter(child: SdVerticalSpacingV5(value: SdSpacingV5.s32)),
      ],
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return ListView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SkeletonBox(
          height: width / UIConstants.productImageAspect * 0.92,
          radius: 0,
        ),
        Padding(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkeletonBox(width: 120),
              SdVerticalSpacingV5(value: SdSpacingV5.s12),
              const SkeletonBox(height: SdSpacingV5.s24, width: 240),
              SdVerticalSpacingV5(value: SdSpacingV5.s12),
              const SkeletonBox(height: SdSpacingV5.s20, width: 96),
              SdVerticalSpacingV5(value: SdSpacingV5.s24),
              const SkeletonBox(height: 120, radius: UIConstants.cardRadius),
            ],
          ),
        ),
      ],
    );
  }
}
