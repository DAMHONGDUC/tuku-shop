import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class BottomActionSection extends StatelessWidget {
  final double price;
  final VoidCallback? onAddToCart;

  const BottomActionSection({super.key, required this.price, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: SdHelperV5.getPageDefaultPadding().copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceDefault,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(SdSpacingV5.s24),
          topRight: Radius.circular(SdSpacingV5.s24),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorTheme.boxShadowSecondary,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Price section
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: SdTextStyleV5.body14().wColor(
                    context.colorTheme.textSubTitle,
                  ),
                ),
                Text(
                  SdCurrencyFormatHelperV5.formatPrice(price),
                  style: SdTextStyleV5.body24()
                      .wColor(context.colorTheme.primary)
                      .wBold(),
                ),
              ],
            ),
            SdHorizontalSpacingV5(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SdButtonV5(
                      title: 'Add to cart',
                      widthType: SdButtonWidthV5.full,
                      onTap: () {},
                      type: SdButtonTypeV5.secondary,
                      colorConfig: SdButtonColorConfigV5.init().copyWith(
                        secondaryBorderColor: context.colorTheme.primary,
                        secondaryTextColor: context.colorTheme.primary,
                      ),
                    ),
                  ),
                  SdHorizontalSpacingV5(),
                  Expanded(
                    child: SdButtonV5(
                      title: 'Buy now',
                      widthType: SdButtonWidthV5.full,
                      colorConfig: SdButtonColorConfigV5.init().copyWith(
                        primaryBgColor: context.colorTheme.primary,
                      ),
                      onTap: () {},
                    ),
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
