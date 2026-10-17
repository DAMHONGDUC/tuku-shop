import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// Brand, name, rating and price.
class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            product.brand.toUpperCase(),
            style: context.textTheme5.labelMedium!.faint5(context).copyWith(
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          if (product.isEco)
            SdBadgeV5(
              label: context.loc.badge_eco,
              tone: SdBadgeToneV5.success,
              icon: Symbols.eco_rounded,
            ),
          if (product.isBestSeller) ...<Widget>[
            SizedBox(width: SdSpacingConstant.w6),
            SdBadgeV5(
              label: context.loc.badge_best_seller,
              tone: SdBadgeToneV5.warning,
              icon: Symbols.local_fire_department_rounded,
            ),
          ],
        ],
      ),
      SizedBox(height: SdSpacingConstant.h6),
      Text(product.name, style: context.textTheme5.headlineLarge),
      SizedBox(height: SdSpacingConstant.h10),
      Row(
        children: <Widget>[
          SdRatingV5(
            rating: product.rating,
            semanticLabel: context.loc.detail_rating(product.rating.toStringAsFixed(1)),
          ),
          SizedBox(width: SdSpacingConstant.w6),
          Text(
            product.rating.toStringAsFixed(1),
            style: context.textTheme5.labelLarge,
          ),
          SizedBox(width: SdSpacingConstant.w6),
          Flexible(
            child: Text(
              '${context.loc.detail_reviews(product.reviewCount)}  ·  ${context.loc.detail_sold(Formatters.compact(product.soldCount))}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme5.labelMedium!.muted5(context),
            ),
          ),
        ],
      ),
      SizedBox(height: SdSpacingConstant.h14),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SdPriceV5(
            price: Formatters.currency(product.price),
            compareAt: product.isOnSale
                ? Formatters.currency(product.compareAtPrice!)
                : null,
            size: SdPriceSizeV5.large,
          ),
          if (product.isOnSale) ...<Widget>[
            SizedBox(width: SdSpacingConstant.w8),
            SdBadgeV5(
              label: context.loc.detail_save(
                Formatters.currency(product.compareAtPrice! - product.price),
              ),
              tone: SdBadgeToneV5.accent,
            ),
          ],
        ],
      ),
    ],
  );
}
