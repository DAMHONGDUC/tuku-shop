import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../widgets/product_grid.dart';
import 'recommended_controller.dart';

/// The recommended grid as slivers, for a screen's own scroll view. The
/// screen provides [RecommendedController] and calls `loadMore` near the end.
class RecommendedSliver extends StatelessWidget {
  const RecommendedSliver({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RecommendedController, RecommendedState>(
        builder: (BuildContext context, RecommendedState state) => SliverMainAxisGroup(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: SdContentPaddingV5.gutter.copyWith(
                  bottom: SdSpacingConstant.h14,
                ),
                child: SdSectionHeaderV5(
                  title: context.loc.home_recommended,
                  subtitle: context.loc.home_recommended_subtitle,
                ),
              ),
            ),
            switch (state.status) {
              LoadStatus.loading => const ProductSliverGridSkeleton(),
              LoadStatus.failure => SliverToBoxAdapter(
                child: ErrorView(onRetry: context.read<RecommendedController>().load),
              ),
              LoadStatus.success => ProductSliverGrid(
                products: state.products,
                heroPrefix: 'recommended',
              ),
            },
            if (state.loadingMore)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SdSpacingConstant.h20),
                  child: const SdLoadingV5(),
                ),
              ),
          ],
        ),
      );
}
