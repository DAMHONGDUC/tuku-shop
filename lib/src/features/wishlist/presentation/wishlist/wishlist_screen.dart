import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import 'wishlist_controller.dart';

/// Favorites: saved products, opened from Profile.
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

    return BlocBuilder<WishlistController, WishlistState>(
      builder: (context, state) {
        final controller = context.read<WishlistController>();
        final empty =
            state.status == WishlistStatus.loaded && state.products.isEmpty;
        return Scaffold(
          backgroundColor: colors.pageDefault,
          bottomNavigationBar: empty
              ? BottomActionBar(
                  child: AppButton(
                    label: context.loc.common_start_shopping,
                    onTap: () => context.go(HomeRoutes.home.fullPath),
                  ),
                )
              : null,
          appBar: AppTopBar(
            title:
                state.status == WishlistStatus.loaded &&
                    state.products.isNotEmpty
                ? context.loc.wishlist_title_count(state.products.length)
                : context.loc.wishlist_title,
          ),
          body: RefreshWrapper(
            onRefresh: controller.load,
            child: empty
                ? FillCenterScrollView(
                    child: EmptyState(
                      icon: Icons.favorite_border,
                      title: context.loc.wishlist_empty_title,
                      message: context.loc.wishlist_empty_message,
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.fromLTRB(
                      SdSpacingV5.s16,
                      SdSpacingV5.s8,
                      SdSpacingV5.s16,
                      MediaQuery.paddingOf(context).bottom + SdSpacingV5.s24,
                    ),
                    children: [
                      switch (state.status) {
                        WishlistStatus.loading => ProductGrid(
                          itemCount: 0,
                          trailingSkeletons: 4,
                          itemBuilder: (_, _) => const SizedBox.shrink(),
                        ),
                        WishlistStatus.error => SectionError(
                          onRetry: controller.load,
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
                              soldCount: product.purchaserCount,
                              isFavorite: true,
                              isSoldOut: !product.isInStock,
                              onFavoriteTap: () =>
                                  controller.remove(product.id),
                              onTap: () => context.push(
                                ProductRoutes.productDetailLocation(product.id),
                              ),
                            );
                          },
                        ),
                      },
                    ],
                  ),
          ),
        );
      },
    );
  }
}
