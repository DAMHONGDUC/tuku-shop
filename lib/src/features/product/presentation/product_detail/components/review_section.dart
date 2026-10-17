import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/widgets/review_comment_item.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart' hide SdContextV2X;

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final limitedReviews = product.reviewComments.take(2).toList();
    final reviewAvailable = product.reviewComments.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: SdSpacingV5.s12),
      color: context.colorTheme.surfaceDefault,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
            child: Row(
              children: [
                Row(
                  children: [
                    const SdIconV5(iconData: Icons.star, color: Colors.amber),
                    const SdHorizontalSpacingV5(xRatio: 0.4),
                    Text(
                      product.averageRating.toStringAsFixed(1),
                      style: SdTextStyleV5.heading16(),
                    ),
                    const SdHorizontalSpacingV5(xRatio: 0.5),
                    Text(
                      ' (${product.reviewComments.length} Reviews)',
                      style: SdTextStyleV5.body14().copyWith(
                        color: context.colorTheme.textSubTitle,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                if (reviewAvailable)
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to review screen
                    },
                    child: Text(
                      "View All",
                      style: context.textTheme.heading12.wColor(
                        AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (reviewAvailable) ...[
            SdVerticalSpacingV5(),
            SdDividerV5(),
            SdVerticalSpacingV5(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
              child: Column(
                children: [
                  ...limitedReviews.mapIndexed(
                    (index, review) => ReviewCommentItem(
                      review: review,
                      isLast: index == limitedReviews.length - 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
