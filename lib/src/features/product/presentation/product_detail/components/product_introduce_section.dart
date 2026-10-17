import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class ProductIntroduceSection extends StatelessWidget {
  final ProductEntity product;

  const ProductIntroduceSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SdSpacingV5.s16,
        vertical: SdSpacingV5.s12,
      ),
      color: context.colorTheme.surfaceDefault,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: SdTextStyleV5.heading24(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SdHorizontalSpacingV5(),
              Row(
                children: [
                  Text(
                    'sold ${product.purchaserCount}',
                    style: SdTextStyleV5.body14().wSemiBold(),
                  ),
                  SdHorizontalSpacingV5(),
                  SdIconV5(
                    iconData: Icons.favorite_border,
                    color: context.colorTheme.iconDefault,
                    iconSize: SdSpacingV5.s20,
                  ),
                ],
              ),
            ],
          ),
          SdVerticalSpacingV5(xRatio: 0.25),
          Text(
            SdCurrencyFormatHelperV5.formatPrice(product.price),
            style: SdTextStyleV5.body20().wBold().wColor(
              context.colorTheme.primary,
            ),
          ),
          if (product.brand.isNotEmpty) ...[
            SdVerticalSpacingV5(xRatio: 0.5),
            Text(
              product.brand,
              style: SdTextStyleV5.body16().copyWith(
                color: context.colorTheme.textSubTitle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
