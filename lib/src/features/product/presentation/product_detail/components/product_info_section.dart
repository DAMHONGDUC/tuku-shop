import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// Brand, rating, name and price: what you check first.
class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              product.brand.toUpperCase(),
              style: SdTextStyleV5.body12()
                  .wSemiBold()
                  .wColor(colors.textSubTitle)
                  .wEyebrow(),
            ),
            const Spacer(),
            Icon(
              Icons.star_rounded,
              size: SdSpacingV5.s16,
              color: colors.warning,
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s4),
            Text(
              '${product.averageRating.toStringAsFixed(1)} '
              '(${product.ratingCount}) · '
              '${context.loc.pdp_sold(product.purchaserCount)}',
              style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
            ),
          ],
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s8),
        Text(
          product.name,
          style: SdTextStyleV5.heading24()
              .wColor(colors.textDefault)
              .wDisplay(),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s8),
        Row(
          children: [
            PriceText(
              price: product.price,
              originalPrice: product.originalPrice,
              style: SdTextStyleV5.heading20(),
            ),
            if (product.isOnSale) ...[
              SdHorizontalSpacingV5(value: SdSpacingV5.s8),
              TagChip(
                label: context.loc.badge_discount(product.discountPercent),
                color: colors.sale,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// Shipping, delivery and returns as three small tiles.
class TrustRow extends StatelessWidget {
  const TrustRow({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        Icons.local_shipping_outlined,
        context.loc.pdp_free_shipping,
        context.loc.pdp_free_shipping_sub,
      ),
      (
        Icons.schedule_outlined,
        context.loc.pdp_delivery,
        context.loc.pdp_delivery_sub,
      ),
      (
        Icons.replay_outlined,
        context.loc.pdp_returns,
        context.loc.pdp_returns_sub,
      ),
    ];
    final colors = context.colorTheme;

    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) SdHorizontalSpacingV5(value: SdSpacingV5.s8),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: SdSpacingV5.s12,
                horizontal: SdSpacingV5.s8,
              ),
              decoration: BoxDecoration(
                color: colors.cardDefault,
                borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                border: Border.all(color: colors.borderDefault),
              ),
              child: Column(
                children: [
                  SdIconV5(
                    iconData: items[i].$1,
                    iconSize: SdSpacingV5.s20,
                    color: colors.accent,
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s4),
                  Text(
                    items[i].$2,
                    textAlign: TextAlign.center,
                    style: SdTextStyleV5.body12().wSemiBold().wColor(
                      colors.textDefault,
                    ),
                  ),
                  Text(
                    items[i].$3,
                    textAlign: TextAlign.center,
                    style: SdTextStyleV5.body10().wColor(colors.textSubTitle),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Description, material and fit.
class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final label = SdTextStyleV5.body12().wColor(colors.textSubTitle);
    final value = SdTextStyleV5.body14().wColor(colors.textDefault);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.pdp_details,
          style: SdTextStyleV5.heading16().wColor(colors.textDefault),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        // Blank lines split the copy into paragraphs; a paragraph with more
        // than one line starts with its heading ("Care", "Size & fit").
        // Description photos sit between paragraphs, one after each.
        if (product.description != null)
          for (final (i, block)
              in product.description!.content.split('\n\n').indexed) ...[
            if (i > 0) SdVerticalSpacingV5(value: SdSpacingV5.s16),
            if (i > 0 && i - 1 < product.description!.images.length) ...[
              _DescriptionImage(
                images: product.description!.images,
                index: i - 1,
              ),
              SdVerticalSpacingV5(value: SdSpacingV5.s16),
            ],
            if (block.contains('\n')) ...[
              Text(
                block.substring(0, block.indexOf('\n')),
                style: SdTextStyleV5.body14().wSemiBold().wColor(
                  colors.textDefault,
                ),
              ),
              SdVerticalSpacingV5(value: SdSpacingV5.s4),
              Text(
                block.substring(block.indexOf('\n') + 1),
                style: value.copyWith(height: 1.5),
              ),
            ] else
              Text(block, style: value.copyWith(height: 1.5)),
          ],
        SdVerticalSpacingV5(value: SdSpacingV5.s16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.loc.pdp_material, style: label),
                  Text(product.material, style: value),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.loc.pdp_fit, style: label),
                  Text(product.fit, style: value),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// A description photo; tap to see every description photo full screen.
class _DescriptionImage extends StatelessWidget {
  const _DescriptionImage({required this.images, required this.index});

  final List<String> images;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      button: true,
      child: GestureDetector(
        onTap: () => SdPreviewMediaViewV5.show(
          context: context,
          items: [
            for (final path in images)
              SdPreviewMediaConfigV5(
                filePath: path,
                isVideo: false,
                isAsset: true,
              ),
          ],
          initialIndex: index,
        ),
        child: AspectRatio(
          aspectRatio: UIConstants.productImageAspect,
          child: CatalogImage(
            path: images[index],
            borderRadius: UIConstants.imageRadius,
          ),
        ),
      ),
    );
  }
}
