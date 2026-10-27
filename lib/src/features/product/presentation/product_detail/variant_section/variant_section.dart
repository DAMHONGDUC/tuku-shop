import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'variant_selection_controller.dart';

/// Color swatches and size (or phone model) chips; sold-out options stay
/// visible, struck through.
class VariantSection extends StatelessWidget {
  const VariantSection({super.key, required this.product});

  final ProductEntity product;

  static Color parseHex(String hex) =>
      Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BlocBuilder<VariantSelectionController, VariantSelectionState>(
      builder: (context, state) {
        final controller = context.read<VariantSelectionController>();
        final stock = state.stock;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: '${context.loc.pdp_color} · ',
                style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                children: [
                  TextSpan(
                    text: state.colorName ?? '',
                    style: SdTextStyleV5.body14().wSemiBold().wColor(
                      colors.textDefault,
                    ),
                  ),
                ],
              ),
            ),
            SdVerticalSpacingV5(value: SdSpacingV5.s8),
            Wrap(
              spacing: SdSpacingV5.s4,
              children: [
                for (final color in product.productColors)
                  _Swatch(
                    color: parseHex(color.colorCode),
                    label: color.colorName,
                    selected: color.colorName == state.colorName,
                    onTap: () => controller.selectColor(color.colorName),
                  ),
              ],
            ),
            SdVerticalSpacingV5(value: SdSpacingV5.s16),
            Row(
              children: [
                Text(
                  product.secondOption == ProductOptionKind.model
                      ? context.loc.pdp_model
                      : context.loc.pdp_size,
                  style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                ),
                const Spacer(),
                if (stock != null && stock > 0 && stock <= 5)
                  Text(
                    context.loc.pdp_only_left(stock),
                    style: SdTextStyleV5.body12().wSemiBold().wColor(
                      colors.sale,
                    ),
                  ),
              ],
            ),
            SdVerticalSpacingV5(value: SdSpacingV5.s8),
            Wrap(
              spacing: SdSpacingV5.s8,
              runSpacing: SdSpacingV5.s8,
              children: [
                for (final size in product.productSizes)
                  AppChip(
                    label: size.name,
                    selected: size.name == state.size,
                    enabled: state.isSizeAvailable(size.name),
                    onTap: () => controller.selectSize(size.name),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.color,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox.square(
          dimension: UIConstants.minTapTarget,
          child: Center(
            child: AnimatedContainer(
              duration: UIConstants.navFast,
              width: SdSpacingV5.s32,
              height: SdSpacingV5.s32,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: colors.cardDefault, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: selected ? colors.primary : colors.borderDefault,
                    spreadRadius: selected ? 2 : 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
