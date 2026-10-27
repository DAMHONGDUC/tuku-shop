import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// [ProductTile] for a [ProductEntity]: sale and "New" badges, and a tap that
/// opens the product.
class ProductEntityTile extends StatelessWidget {
  const ProductEntityTile({
    super.key,
    required this.product,
    this.isFavorite,
    this.onFavoriteTap,
  });

  final ProductEntity product;
  final bool? isFavorite;
  final VoidCallback? onFavoriteTap;

  static void openProduct(BuildContext context, String productId) {
    context.push(ProductRoutes.productDetailLocation(productId));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final (badge, badgeColor) = product.isOnSale
        ? (context.loc.badge_discount(product.discountPercent), colors.sale)
        : product.tags.contains(ProductTag.newArrival)
        ? (context.loc.badge_new, colors.primary)
        : (null, null);

    return ProductTile(
      imageUrl: product.imageUrl,
      name: product.name,
      brand: product.brand,
      price: product.price,
      originalPrice: product.originalPrice,
      rating: product.averageRating,
      soldCount: product.purchaserCount,
      badgeText: badge,
      badgeColor: badgeColor,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      isSoldOut: !product.isInStock,
      onTap: () => openProduct(context, product.id),
    );
  }
}
