import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'product_reviews_controller.dart';

/// "All", then the product's colors, then its sizes (or phone models): one
/// row of chips that narrows the nearest [ProductReviewsController].
class ReviewFilterChips extends StatelessWidget {
  const ReviewFilterChips({
    super.key,
    required this.product,
    this.padding = EdgeInsets.zero,
  });

  final ProductEntity product;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final sizes = [
      for (final s in product.productSizes)
        if (s.name != 'One size') s.name,
    ];
    if (product.productColors.length < 2 && sizes.length < 2) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<ProductReviewsController, ProductReviewsState>(
      buildWhen: (a, b) =>
          a.colorFilter != b.colorFilter || a.sizeFilter != b.sizeFilter,
      builder: (context, state) {
        final controller = context.read<ProductReviewsController>();
        Widget gap() => SdHorizontalSpacingV5(value: SdSpacingV5.s8);

        return SizedBox(
          height: SdSpacingV5.s36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: padding,
            children: [
              AppChip(
                label: context.loc.review_filter_all,
                selected: !state.isFiltered,
                onTap: controller.clearFilter,
              ),
              gap(),
              for (final c in product.productColors) ...[
                AppChip(
                  label: c.colorName,
                  selected: state.colorFilter == c.colorName,
                  onTap: () => controller.toggleColor(c.colorName),
                ),
                gap(),
              ],
              if (sizes.isNotEmpty) ...[
                Center(
                  child: Container(
                    width: 1,
                    height: SdSpacingV5.s20,
                    color: colors.borderDefault,
                  ),
                ),
                gap(),
              ],
              for (final size in sizes) ...[
                AppChip(
                  label: size,
                  selected: state.sizeFilter == size,
                  onTap: () => controller.toggleSize(size),
                ),
                gap(),
              ],
            ],
          ),
        );
      },
    );
  }
}
