import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../widgets/review_widgets.dart';
import 'product_reviews_controller.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context) => BlocProvider<ProductReviewsController>(
    create: (BuildContext _) =>
        getIt<ProductReviewsController>()..load(productId),
    child: SdScaffoldV5(
      appBar: SdAppBarV5(title: context.loc.detail_reviews_title),
      body: BlocBuilder<ProductReviewsController, ProductReviewsState>(
        builder: (BuildContext context, ProductReviewsState state) =>
            FadeSwitcher(
              child: switch (state.status) {
                LoadStatus.loading => const _ReviewsSkeleton(),
                LoadStatus.failure => ErrorView(
                  onRetry: () =>
                      context.read<ProductReviewsController>().load(productId),
                ),
                LoadStatus.success => _ReviewsList(state: state),
              },
            ),
      ),
    ),
  );
}

class _ReviewsList extends StatelessWidget {
  const _ReviewsList({required this.state});

  final ProductReviewsState state;

  @override
  Widget build(BuildContext context) {
    final ProductReviewsController controller = context
        .read<ProductReviewsController>();
    final List<ReviewEntity> visible = state.visible;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification n) {
        if (n.metrics.extentAfter < 400) controller.loadMore();
        return false;
      },
      child: ListView(
        padding: SdContentPaddingV5.gutter.copyWith(
          top: SdSpacingConstant.h8,
          bottom: SdContentPaddingV5.detailBottom(context),
        ),
        children: <Widget>[
          RatingSummary(summary: state.summary!),
          SizedBox(height: SdSpacingConstant.h20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                SdChipV5(
                  label: context.loc.gender_all,
                  selected: state.starFilter == null,
                  onSelected: () => controller.setStarFilter(null),
                ),
                for (int stars = 5; stars >= 1; stars--) ...<Widget>[
                  SizedBox(width: SdSpacingConstant.w8),
                  SdChipV5(
                    label: '$stars',
                    icon: Symbols.star_rounded,
                    selected: state.starFilter == stars,
                    onSelected: () => controller.setStarFilter(stars),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: SdSpacingConstant.h8),
          if (visible.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: SdSpacingConstant.h40),
              child: SdEmptyStateV5(
                icon: Symbols.reviews_rounded,
                title: context.loc.reviews_empty,
              ),
            ),
          for (final (int i, ReviewEntity r) in visible.indexed) ...<Widget>[
            SdDividerV5(spacing: SdSpacingConstant.h32),
            SdFadeInV5(
              index: i % 6,
              child: ReviewTile(review: r),
            ),
          ],
          if (state.loadingMore)
            Padding(
              padding: EdgeInsets.symmetric(vertical: SdSpacingConstant.h20),
              child: const SdLoadingV5(),
            ),
        ],
      ),
    );
  }
}

class _ReviewsSkeleton extends StatelessWidget {
  const _ReviewsSkeleton();

  @override
  Widget build(BuildContext context) => SdShimmerV5(
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: SdContentPaddingV5.gutter,
      children: <Widget>[
        SdSkeletonV5(height: SdSpacingConstant.h108),
        for (int i = 0; i < 4; i++) ...<Widget>[
          SizedBox(height: SdSpacingConstant.h24),
          SdSkeletonV5(height: SdSpacingConstant.h96),
        ],
      ],
    ),
  );
}
