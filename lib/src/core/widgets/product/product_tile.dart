import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A product card built from plain values, so any feature can show one
/// without importing the product feature. Editorial layout: the photo
/// carries the card, text sits on the page below it.
class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.price,
    required this.onTap,
    this.originalPrice,
    this.rating,
    this.soldCount,
    this.badgeText,
    this.badgeColor,
    this.isFavorite,
    this.onFavoriteTap,
    this.isSoldOut = false,
  });

  final String imageUrl;
  final String name;
  final String brand;
  final double price;
  final double? originalPrice;
  final double? rating;
  final int? soldCount;
  final String? badgeText;
  final Color? badgeColor;

  /// Null hides the heart.
  final bool? isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback onTap;
  final bool isSoldOut;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final meta = [
      if (rating != null && rating! > 0) '★ ${rating!.toStringAsFixed(1)}',
      if (soldCount != null && soldCount! > 0)
        context.loc.product_sold_count(AppFormat.compactCount(soldCount!)),
    ].join('  ·  ');

    return Semantics(
      button: true,
      label: '$brand, $name',
      child: Pressable(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: UIConstants.productImageAspect,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(UIConstants.imageRadius),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: colors.cardOnSurface),
                    CatalogImage(path: imageUrl),
                    if (isSoldOut) ...[
                      ColoredBox(
                        color: colors.pageDefault.withValues(alpha: 0.55),
                      ),
                      Center(
                        child: TagChip(
                          label: context.loc.pdp_sold_out,
                          color: colors.textDefault,
                        ),
                      ),
                    ],
                    if (badgeText != null)
                      Positioned(
                        left: SdSpacingV5.s8,
                        top: SdSpacingV5.s8,
                        child: TagChip(
                          label: badgeText!,
                          color: badgeColor ?? colors.sale,
                        ),
                      ),
                    if (isFavorite != null)
                      Positioned(
                        right: SdSpacingV5.s2,
                        top: SdSpacingV5.s2,
                        child: FavoriteButton(
                          isFavorite: isFavorite!,
                          onTap: onFavoriteTap,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                SdSpacingV5.s2,
                SdSpacingV5.s8,
                SdSpacingV5.s2,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SdTextStyleV5.body10()
                        .wSemiBold()
                        .wColor(colors.textSubTitle)
                        .wEyebrow(),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s2),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SdTextStyleV5.body14().wColor(colors.textDefault),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s4),
                  PriceText(price: price, originalPrice: originalPrice),
                  SdVerticalSpacingV5(value: SdSpacingV5.s2),
                  Text(
                    meta,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SdTextStyleV5.body10().wColor(colors.textSubTitle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final foreground = color.computeLuminance() > 0.5
        ? AppColors.ink
        : SdColorsV5.white;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SdSpacingV5.s6,
        vertical: SdSpacingV5.s2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(SdSpacingV5.s4),
      ),
      child: Text(
        label.toUpperCase(),
        style: SdTextStyleV5.body10()
            .wSemiBold()
            .wColor(foreground)
            .copyWith(letterSpacing: 0.8),
      ),
    );
  }
}

/// A 44 pt tap target holding a 28 pt heart disc.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.isFavorite, this.onTap});

  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Semantics(
      button: true,
      selected: isFavorite,
      label: context.loc.wishlist_title,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox.square(
          dimension: UIConstants.minTapTarget,
          child: Center(
            child: Container(
              width: SdSpacingV5.s28,
              height: SdSpacingV5.s28,
              decoration: BoxDecoration(
                color: SdColorsV5.white.withValues(alpha: 0.92),
                shape: BoxShape.circle,
              ),
              child: AnimatedSwitcher(
                duration: UIConstants.navFast,
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(isFavorite),
                  size: SdSpacingV5.s16,
                  color: isFavorite ? colors.sale : AppColors.ink,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTileSkeleton extends StatelessWidget {
  const ProductTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: UIConstants.productImageAspect,
          child: SkeletonBox(
            radius: UIConstants.imageRadius,
            height: double.infinity,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(height: SdSpacingV5.s12),
              SdVerticalSpacingV5(value: SdSpacingV5.s8),
              SkeletonBox(height: SdSpacingV5.s10, width: 80),
              SdVerticalSpacingV5(value: SdSpacingV5.s8),
              SkeletonBox(height: SdSpacingV5.s14, width: 56),
            ],
          ),
        ),
      ],
    );
  }
}
