import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart' hide SdContextV2X;

const kImageSize = 150.0;

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onPress;

  const ProductCard({super.key, required this.product, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SdInkWellV5(
      borderRadius: 0,
      contentPadding: EdgeInsets.zero,
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surfaceDefault,
          borderRadius: BorderRadius.circular(SdSpacingV5.s12),
          boxShadow: [
            BoxShadow(
              color: context.colorTheme.boxShadowDefault,
              blurRadius: SdSpacingV5.s6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            SizedBox(
              height: kImageSize,
              child: _CardImageView(imageUrl: product.imageUrl),
            ),
            Container(
              padding: EdgeInsets.all(SdSpacingV5.s8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name
                  Text(product.name, style: context.textTheme.body14),
                  SizedBox(height: SdSpacingV5.s2),

                  // brand
                  Text(
                    product.brand,
                    style: context.textTheme.body12.wColor(
                      context.colorTheme.textSubTitle,
                    ),
                  ),
                  SizedBox(height: SdSpacingV5.s8),

                  // price
                  Text(
                    SdCurrencyFormatHelperV5.formatPrice(product.price),
                    style: context.textTheme.heading16.wBold(),
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

class _CardImageView extends StatelessWidget {
  const _CardImageView({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SdSpacingV5.s8),
              topRight: Radius.circular(SdSpacingV5.s8),
            ),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: SdSpacingV5.s8,
          right: SdSpacingV5.s8,
          child: Container(
            decoration: BoxDecoration(
              color: SdColorsV5.grey900,
              borderRadius: BorderRadius.all(Radius.circular(SdSpacingV5.s100)),
            ),
            child: Padding(
              padding: EdgeInsets.all(SdSpacingV5.s6),
              child: SdIconV5(
                iconData: Icons.favorite_border,
                color: AppColors.white,
                iconSize: SdSpacingV5.s16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
