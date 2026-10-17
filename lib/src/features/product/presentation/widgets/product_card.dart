import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/wishlist_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// A product tile: photo with its badges and heart, then brand, name, price
/// and rating. The photo is a [Hero] keyed by [heroTag], so it flies into the
/// product page — the tag carries the section, because one product can sit
/// in two rails of the same screen.
class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, required this.heroTag, super.key});

  final ProductEntity product;
  final String heroTag;

  static const double imageAspect = 0.8;

  /// The text block under the photo.
  static double get infoHeight => SdSpacingConstant.h96 * 0.92;

  /// The card's full height at [width].
  static double heightFor(double width) => width / imageAspect + infoHeight;

  @override
  Widget build(BuildContext context) => SdPressableV5(
    semanticLabel: product.name,
    onTap: () => context.push(
      AppRoutes.productPath(product.id),
      extra: ProductDetailArgs(heroTag: heroTag),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: imageAspect,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Hero(
                  tag: heroTag,
                  child: AppImage(
                    product.coverImage,
                    borderRadius: SdRadiusV5.photoAll,
                  ),
                ),
              ),
              Positioned(
                top: SdSpacingConstant.h8,
                left: SdSpacingConstant.w8,
                child: ProductBadges(product: product),
              ),
              Positioned(
                top: SdSpacingConstant.h8,
                right: SdSpacingConstant.w8,
                child: ProductLikeButton(productId: product.id),
              ),
            ],
          ),
        ),
        SizedBox(height: SdSpacingConstant.h10),
        Text(
          product.brand.toUpperCase(),
          maxLines: 1,
          style: context.textTheme5.labelSmall!
              .faint5(context)
              .copyWith(letterSpacing: 0.8),
        ),
        SizedBox(height: SdSpacingConstant.h2),
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme5.titleSmall,
        ),
        SizedBox(height: SdSpacingConstant.h4),
        Row(
          children: <Widget>[
            Expanded(
              child: SdPriceV5(
                price: Formatters.currency(product.price),
                compareAt: product.isOnSale
                    ? Formatters.currency(product.compareAtPrice!)
                    : null,
                size: SdPriceSizeV5.small,
              ),
            ),
            SdIconV5(
              Symbols.star_rounded,
              size: SdIconV5.smallSize * 0.9,
              fill: 1,
              color: context.sdTheme5.rating,
            ),
            SizedBox(width: SdSpacingConstant.w2),
            Text(
              product.rating.toStringAsFixed(1),
              style: context.textTheme5.labelMedium!.muted5(context),
            ),
          ],
        ),
      ],
    ),
  );
}

/// −30% and NEW, stacked in the photo's corner.
class ProductBadges extends StatelessWidget {
  const ProductBadges({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      if (product.isOnSale)
        SdBadgeV5(
          label: Formatters.discount(product.price, product.compareAtPrice!),
          tone: SdBadgeToneV5.accent,
          solid: true,
        ),
      if (product.isOnSale && product.isNew)
        SizedBox(height: SdSpacingConstant.h4),
      if (product.isNew)
        SdBadgeV5(label: context.loc.badge_new, tone: SdBadgeToneV5.inverse),
    ],
  );
}

/// The heart on a product photo, bound to the shared wishlist.
class ProductLikeButton extends StatelessWidget {
  const ProductLikeButton({required this.productId, this.size, super.key});

  final String productId;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final bool liked = context.select<WishlistController, bool>(
      (WishlistController c) => c.state.contains(productId),
    );

    return SdLikeButtonV5(
      liked: liked,
      size: size,
      tooltip: liked ? context.loc.wishlist_remove : context.loc.wishlist_add,
      onChanged: (bool _) =>
          context.read<WishlistController>().toggle(productId),
    );
  }
}
