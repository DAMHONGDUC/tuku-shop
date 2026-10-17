import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../../widgets/review_widgets.dart';
import '../product_detail_controller.dart';

/// The rating breakdown and the first two reviews, with the rest a tap away.
class ReviewPreviewSection extends StatelessWidget {
  const ReviewPreviewSection({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDetailController, ProductDetailState>(
        buildWhen: (ProductDetailState a, ProductDetailState b) =>
            a.reviews != b.reviews,
        builder: (BuildContext context, ProductDetailState state) {
          final ReviewsPage? reviews = state.reviews;
          final String id = state.product!.id;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SdSectionHeaderV5(
                title: context.loc.detail_reviews_title,
                actionLabel: context.loc.action_see_all,
                onAction: () => context.push(AppRoutes.productReviewsPath(id)),
              ),
              SizedBox(height: SdSpacingConstant.h16),
              FadeSwitcher(
                child: reviews == null
                    ? SdShimmerV5(
                        child: SdSkeletonV5(height: SdSpacingConstant.h108),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          RatingSummary(summary: reviews.summary),
                          for (final ReviewEntity r in reviews.items.take(
                            2,
                          )) ...<Widget>[
                            SdDividerV5(spacing: SdSpacingConstant.h32),
                            ReviewTile(review: r),
                          ],
                          SizedBox(height: SdSpacingConstant.h16),
                          SdButtonV5(
                            variant: SdButtonVariantV5.outlined,
                            label: context.loc.detail_all_reviews(
                              reviews.summary.total,
                            ),
                            expand: true,
                            onPressed: () =>
                                context.push(AppRoutes.productReviewsPath(id)),
                          ),
                        ],
                      ),
              ),
            ],
          );
        },
      );
}
