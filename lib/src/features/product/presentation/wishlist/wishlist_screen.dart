import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/wishlist_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../widgets/product_card.dart';
import '../widgets/product_grid.dart';
import 'components/quick_add_sheet.dart';
import 'wishlist_controller.dart';

/// The Saved tab.
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<WishlistScreenController>(
    create: (BuildContext context) =>
        getIt<WishlistScreenController>()
          ..sync(context.read<WishlistController>().state),
    child: BlocListener<WishlistController, List<String>>(
      listener: (BuildContext context, List<String> ids) =>
          context.read<WishlistScreenController>().sync(ids),
      child: SdScaffoldV5(
        body: BlocBuilder<WishlistScreenController, WishlistScreenState>(
          builder: (BuildContext context, WishlistScreenState state) =>
              CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: SdContentPaddingV5.gutter.copyWith(
                        top:
                            SdContentPaddingV5.statusBarInset(context) +
                            SdSpacingConstant.h16,
                        bottom: SdSpacingConstant.h16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            context.loc.wishlist_title,
                            style: context.textTheme5.displaySmall,
                          ),
                          SizedBox(height: SdSpacingConstant.h4),
                          Text(
                            context.loc.wishlist_count(state.products.length),
                            style: context.textTheme5.bodyMedium!.muted5(
                              context,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  switch (state.status) {
                    LoadStatus.loading => const ProductSliverGridSkeleton(),
                    LoadStatus.failure => SliverFillRemaining(
                      hasScrollBody: false,
                      child: ErrorView(
                        onRetry: () => context
                            .read<WishlistScreenController>()
                            .sync(context.read<WishlistController>().state),
                      ),
                    ),
                    LoadStatus.success when state.products.isEmpty =>
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: SdContentPaddingV5.aboveNavBar(context),
                          ),
                          child: SdEmptyStateV5(
                            icon: Symbols.favorite_rounded,
                            title: context.loc.wishlist_empty_title,
                            message: context.loc.wishlist_empty_message,
                            action: SdButtonV5(
                              variant: SdButtonVariantV5.primary,
                              label: context.loc.action_start_shopping,
                              onPressed: () => context.go(AppRoutes.shop.path),
                            ),
                          ),
                        ),
                      ),
                    LoadStatus.success => _SavedGrid(products: state.products),
                  },
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: SdContentPaddingV5.aboveNavBar(context),
                    ),
                  ),
                ],
              ),
        ),
      ),
    ),
  );
}

class _SavedGrid extends StatelessWidget {
  const _SavedGrid({required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    final double width = ProductSliverGrid.cardWidth(context);

    return SliverPadding(
      padding: SdContentPaddingV5.gutter,
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: SdContentPaddingV5.gridGap,
          mainAxisSpacing: SdSpacingConstant.h20,
          mainAxisExtent: ProductCard.heightFor(width) + SdSpacingConstant.h44,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int i) => SdFadeInV5(
          key: ValueKey<String>(products[i].id),
          index: i,
          child: Column(
            children: <Widget>[
              ProductCard(
                product: products[i],
                heroTag: 'saved-${products[i].id}',
              ),
              SizedBox(height: SdSpacingConstant.h8),
              SdButtonV5(
                variant: SdButtonVariantV5.secondary,
                size: SdButtonSizeV5.small,
                label: context.loc.wishlist_move_to_bag,
                icon: Symbols.add_shopping_cart_rounded,
                expand: true,
                onPressed: () => showQuickAddSheet(context, products[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
