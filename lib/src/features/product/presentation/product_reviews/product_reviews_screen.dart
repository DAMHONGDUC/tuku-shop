import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/add_to_cart/add_to_cart_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/add_to_cart/add_to_cart_feedback.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/components/product_action_dock.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/product_detail_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/reviews_section/product_reviews_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/reviews_section/review_filter_chips.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/reviews_section/reviews_section.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_selection_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/widgets/review_comment_item.dart';

/// Every review of one product, paged as you scroll, under the product
/// page's bar (back, name, cart) and its bottom actions.
class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<ProductDetailController>()
                ..getProductDetail(productId: productId),
        ),
        BlocProvider(create: (_) => getIt<VariantSelectionController>()),
        BlocProvider(create: (_) => getIt<AddToCartController>()),
        BlocProvider(
          create: (_) => getIt<ProductReviewsController>()..load(productId),
        ),
      ],
      child: _View(productId: productId),
    );
  }
}

class _View extends StatelessWidget {
  const _View({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return AddToCartFeedback(
      child: BlocConsumer<ProductDetailController, ProductDetailState>(
        listener: (context, state) {
          if (state is ProductDetailLoadedState) {
            context.read<VariantSelectionController>().init(state.product);
          }
        },
        builder: (context, state) {
          final product = state is ProductDetailLoadedState
              ? state.product
              : null;
          final reviews = context.read<ProductReviewsController>();

          return Scaffold(
            backgroundColor: colors.pageDefault,
            appBar: AppTopBar(title: product?.name ?? context.loc.pdp_reviews),
            bottomNavigationBar: product == null
                ? null
                : ProductActionDock(product: product),
            body: LoadMoreListener(
              onLoadMore: reviews.loadMore,
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s16,
                  SdSpacingV5.s8,
                  SdSpacingV5.s16,
                  SdSpacingV5.s24,
                ),
                children: [
                  if (product == null)
                    const SkeletonBox(height: SdSpacingV5.s64)
                  else
                    _Summary(product: product),
                  if (product != null) ...[
                    SdVerticalSpacingV5(value: SdSpacingV5.s12),
                    ReviewFilterChips(product: product),
                  ],
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  _ReviewList(productId: productId),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Average, stars and count, as on the product page.
class _Summary extends StatelessWidget {
  const _Summary({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Container(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      decoration: BoxDecoration(
        color: colors.cardDefault,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      ),
      child: Row(
        children: [
          Text(
            product.averageRating.toStringAsFixed(1),
            style: SdTextStyleV5.heading32().copyWith(
              color: colors.textDefault,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          SdHorizontalSpacingV5(value: SdSpacingV5.s12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReviewStars(rating: product.averageRating),
              SdVerticalSpacingV5(value: SdSpacingV5.s4),
              Text(
                context.loc.pdp_reviews_count(product.ratingCount),
                style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewList extends StatelessWidget {
  const _ReviewList({required this.productId});

  final String productId;

  static Widget _skeleton() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SkeletonBox(height: SdSpacingV5.s14, width: 160),
      SdVerticalSpacingV5(value: SdSpacingV5.s8),
      const SkeletonBox(height: SdSpacingV5.s40),
      SdVerticalSpacingV5(value: SdSpacingV5.s16),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductReviewsController, ProductReviewsState>(
      builder: (context, state) {
        final controller = context.read<ProductReviewsController>();
        return switch (state.status) {
          ProductReviewsStatus.loading => Column(
            children: [for (var i = 0; i < 4; i++) _skeleton()],
          ),
          ProductReviewsStatus.error => SectionError(
            onRetry: () => controller.load(productId),
          ),
          ProductReviewsStatus.loaded when state.items.isEmpty => EmptyState(
            icon: Icons.rate_review_outlined,
            title: context.loc.pdp_reviews,
            message: state.isFiltered
                ? context.loc.review_no_match
                : context.loc.pdp_no_reviews,
          ),
          ProductReviewsStatus.loaded => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < state.items.length; i++)
                ReviewCommentItem(
                  review: state.items[i],
                  isLast: i == state.items.length - 1 && !state.hasMore,
                ),
              if (state.isLoadingMore) ...[
                SdVerticalSpacingV5(value: SdSpacingV5.s16),
                _skeleton(),
              ],
            ],
          ),
        };
      },
    );
  }
}
