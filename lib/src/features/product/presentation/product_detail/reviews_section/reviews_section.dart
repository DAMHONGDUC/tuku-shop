import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/widgets/review_comment_item.dart';

import 'product_reviews_controller.dart';
import 'review_filter_chips.dart';

/// Rating summary from the product and the first few reviews; "View all"
/// opens every review on its own screen.
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.pdp_reviews,
          style: SdTextStyleV5.heading16().wColor(colors.textDefault),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              product.averageRating.toStringAsFixed(1),
              style: SdTextStyleV5.heading24().wColor(colors.textDefault),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s8),
            Padding(
              padding: EdgeInsets.only(bottom: SdSpacingV5.s4),
              child: ReviewStars(rating: product.averageRating),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s8),
            Padding(
              padding: EdgeInsets.only(bottom: SdSpacingV5.s4),
              child: Text(
                context.loc.pdp_reviews_count(product.ratingCount),
                style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
              ),
            ),
          ],
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        ReviewFilterChips(product: product),
        SdVerticalSpacingV5(value: SdSpacingV5.s16),
        BlocBuilder<ProductReviewsController, ProductReviewsState>(
          builder: (context, state) {
            final controller = context.read<ProductReviewsController>();
            switch (state.status) {
              case ProductReviewsStatus.loading:
                return Column(
                  children: [
                    for (var i = 0; i < 2; i++) ...[
                      const SkeletonBox(height: SdSpacingV5.s14, width: 160),
                      SdVerticalSpacingV5(value: SdSpacingV5.s8),
                      const SkeletonBox(height: SdSpacingV5.s40),
                      SdVerticalSpacingV5(value: SdSpacingV5.s16),
                    ],
                  ],
                );
              case ProductReviewsStatus.error:
                return SectionError(onRetry: () => controller.load(product.id));
              case ProductReviewsStatus.loaded when state.items.isEmpty:
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s8),
                  child: Text(
                    context.loc.review_no_match,
                    style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                  ),
                );
              case ProductReviewsStatus.loaded:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < state.items.length; i++)
                      ReviewCommentItem(
                        review: state.items[i],
                        isLast: i == state.items.length - 1,
                      ),
                    if (state.hasMore) ...[
                      SdVerticalSpacingV5(value: SdSpacingV5.s12),
                      AppButton(
                        label: context.loc.pdp_view_all_reviews(
                          state.totalRecord,
                        ),
                        style: AppButtonStyle.soft,
                        onTap: () => context.push(
                          ProductRoutes.productReviewsLocation(product.id),
                        ),
                      ),
                    ],
                  ],
                );
            }
          },
        ),
      ],
    );
  }
}

class ReviewStars extends StatelessWidget {
  const ReviewStars({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          Icon(
            rating >= i
                ? Icons.star_rounded
                : rating > i - 1
                ? Icons.star_half_rounded
                : Icons.star_outline_rounded,
            size: SdSpacingV5.s16,
            color: context.colorTheme.warning,
          ),
      ],
    );
  }
}
