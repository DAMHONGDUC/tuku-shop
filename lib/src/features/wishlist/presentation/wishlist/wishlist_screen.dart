import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import 'wishlist_controller.dart';

/// The Wishlist tab.
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WishlistController>()..load(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return ColoredBox(
      color: colors.pageDefault,
      child: SafeArea(
        bottom: false,
        child: BlocBuilder<WishlistController, WishlistState>(
          builder: (context, state) {
            final controller = context.read<WishlistController>();
            return RefreshWrapper(
              onRefresh: controller.load,
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                  FloatingBottomNav.contentInset(context),
                ),
                children: [
                  Text(
                    state.status == WishlistStatus.loaded &&
                            state.products.isNotEmpty
                        ? context.loc.wishlist_title_count(
                            state.products.length,
                          )
                        : context.loc.wishlist_title,
                    style: SdTextStyleV5.heading24().wColor(colors.textDefault),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  switch (state.status) {
                    WishlistStatus.loading => ProductGrid(
                      itemCount: 0,
                      trailingSkeletons: 4,
                      itemBuilder: (_, _) => const SizedBox.shrink(),
                    ),
                    WishlistStatus.error => SectionError(
                      onRetry: controller.load,
                    ),
                    WishlistStatus.loaded when state.products.isEmpty =>
                      EmptyState(
                        icon: Icons.favorite_border,
                        title: context.loc.wishlist_empty_title,
                        message: context.loc.wishlist_empty_message,
                        actionLabel: context.loc.common_start_shopping,
                        onAction: () => context.go(HomeRoutes.home.fullPath),
                      ),
                    WishlistStatus.loaded => ProductGrid(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductTile(
                          imageUrl: product.imageUrl,
                          name: product.name,
                          brand: product.brand,
                          price: product.price,
                          originalPrice: product.originalPrice,
                          rating: product.averageRating,
                          isFavorite: true,
                          isSoldOut: !product.isInStock,
                          onFavoriteTap: () => controller.remove(product.id),
                          onTap: () => context.push(
                            ProductRoutes.productDetailLocation(product.id),
                          ),
                        );
                      },
                    ),
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
