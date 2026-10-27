import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A price with tabular figures and, when on sale, the struck-through
/// original beside it.
class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.price,
    this.originalPrice,
    this.style,
  });

  final double price;
  final double? originalPrice;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final onSale = originalPrice != null && originalPrice! > price;
    final base = (style ?? SdTextStyleV5.body14().wSemiBold()).copyWith(
      fontFeatures: const [FontFeature.tabularFigures()],
      color: onSale ? colors.sale : colors.textDefault,
    );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: AppFormat.price(price), style: base),
          if (onSale) ...[
            const TextSpan(text: '  '),
            TextSpan(
              text: AppFormat.price(originalPrice!),
              style: SdTextStyleV5.body12().copyWith(
                color: colors.textSubTitle,
                decoration: TextDecoration.lineThrough,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
