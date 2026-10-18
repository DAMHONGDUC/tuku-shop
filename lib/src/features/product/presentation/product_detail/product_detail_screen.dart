import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorites_controller.dart';

import 'add_to_cart/add_to_cart_controller.dart';
import 'add_to_cart/add_to_cart_sheet.dart';
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
          create: (_) =>
              getIt<ProductReviewsController>()..load(args.productId),
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

    return BlocListener<AddToCartController, AddToCartState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: _onAddToCart,
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
                      ? colors.cardDefault
                      : SdColorsV5.transparent,
                  surfaceTintColor: SdColorsV5.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  centerTitle: true,
                  title: collapsed && state is ProductDetailLoadedState
                      ? Text(
                          state.product.name,
                          style: SdTextStyleV5.heading16().wColor(
                            colors.textDefault,
                          ),
                        )
                      : null,
                  leading: Padding(
                    padding: EdgeInsets.all(SdSpacingV5.s4),
                    child: _RoundIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      label: MaterialLocalizations.of(
                        context,
                      ).backButtonTooltip,
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: state is ProductDetailLoadedState
                ? _Dock(product: state.product)
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

  void _onAddToCart(BuildContext context, AddToCartState state) {
    final messenger = ScaffoldMessenger.of(context);
    switch (state.status) {
      case AddToCartStatus.added when state.buyNow:
        context.push(CheckoutRoutes.checkoutLocation(lineIds: [state.lineId!]));
      case AddToCartStatus.added:
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(context.loc.pdp_added_to_cart),
              action: SnackBarAction(
                label: context.loc.pdp_view_cart,
                onPressed: () => context.go(CartRoutes.cart.fullPath),
              ),
            ),
          );
      case AddToCartStatus.failed:
        messenger.showSnackBar(
          SnackBar(content: Text(context.loc.pdp_add_failed)),
        );
      default:
        break;
    }
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

class _Dock extends StatelessWidget {
  const _Dock({required this.product});

  final ProductEntity product;

  void _addToCart(BuildContext context, {required bool buyNow}) {
    AddToCartSheet.show(context, product: product, buyNow: buyNow);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.cardDefault,
        border: Border(top: BorderSide(color: colors.borderDefault)),
      ),
      padding: EdgeInsets.fromLTRB(
        SdSpacingV5.s16,
        SdSpacingV5.s12,
        SdSpacingV5.s16,
        SdSpacingV5.s12 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Row(
        children: [
          BlocSelector<FavoritesController, FavoritesState, bool>(
            selector: (state) => state.contains(product.id),
            builder: (context, isFavorite) => _RoundIconButton(
              icon: isFavorite ? Icons.favorite : Icons.favorite_border,
              iconColor: isFavorite ? colors.sale : colors.textDefault,
              label: context.loc.wishlist_title,
              bordered: true,
              onTap: () =>
                  context.read<FavoritesController>().toggle(product.id),
            ),
          ),
          SdHorizontalSpacingV5(value: SdSpacingV5.s12),
          Expanded(
            child: AppButton(
              label: context.loc.pdp_buy_now,
              style: AppButtonStyle.soft,
              onTap: product.isInStock
                  ? () => _addToCart(context, buyNow: true)
                  : null,
            ),
          ),
          SdHorizontalSpacingV5(value: SdSpacingV5.s12),
          Expanded(
            child: AppButton(
              label: product.isInStock
                  ? context.loc.pdp_add_to_cart
                  : context.loc.pdp_sold_out,
              onTap: product.isInStock
                  ? () => _addToCart(context, buyNow: false)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.bordered = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: colors.cardDefault.withValues(alpha: bordered ? 1 : 0.9),
        shape: CircleBorder(
          side: bordered
              ? BorderSide(color: colors.borderDefault)
              : BorderSide.none,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox.square(
            dimension: UIConstants.minTapTarget,
            child: Icon(
              icon,
              size: SdSpacingV5.s20,
              color: iconColor ?? colors.textDefault,
            ),
          ),
        ),
      ),
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
