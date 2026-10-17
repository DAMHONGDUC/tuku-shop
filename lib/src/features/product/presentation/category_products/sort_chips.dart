import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// Sort and "On sale" as chips: one tap each, no modal.
class SortChips extends StatelessWidget {
  const SortChips({
    super.key,
    required this.sort,
    required this.onSaleOnly,
    required this.onSortChanged,
    required this.onSaleToggled,
    this.showSaleChip = true,
  });

  final ProductSort sort;
  final bool onSaleOnly;
  final ValueChanged<ProductSort> onSortChanged;
  final VoidCallback onSaleToggled;
  final bool showSaleChip;

  static String label(BuildContext context, ProductSort sort) => switch (sort) {
    ProductSort.recommended => context.loc.sort_recommended,
    ProductSort.newest => context.loc.sort_newest,
    ProductSort.priceLowToHigh => context.loc.sort_price_low,
    ProductSort.priceHighToLow => context.loc.sort_price_high,
    ProductSort.rating => context.loc.sort_rating,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SdSpacingV5.s36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
        children: [
          for (final option in ProductSort.values) ...[
            AppChip(
              label: label(context, option),
              selected: option == sort,
              onTap: () => onSortChanged(option),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s8),
          ],
          if (showSaleChip)
            AppChip(
              label: context.loc.filter_on_sale,
              selected: onSaleOnly,
              icon: Icons.local_offer_outlined,
              onTap: onSaleToggled,
            ),
        ],
      ),
    );
  }
}
