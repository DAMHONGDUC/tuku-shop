import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'product_reviews_controller.dart';

/// Filters the nearest [ProductReviewsController] by variation: a Color row
/// and a Model (or Size) row, each with its own "All". The two combine,
/// e.g. Midnight on iPhone 17. A row with one option or less is hidden.
class ReviewFilterChips extends StatelessWidget {
  const ReviewFilterChips({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final colorNames = [for (final c in product.productColors) c.colorName];
    final sizes = [
      for (final s in product.productSizes)
        if (s.name != 'One size') s.name,
    ];
    final secondLabel = product.secondOption == ProductOptionKind.model
        ? loc.pdp_model
        : loc.pdp_size;

    return BlocBuilder<ProductReviewsController, ProductReviewsState>(
      buildWhen: (a, b) =>
          a.colorFilter != b.colorFilter || a.sizeFilter != b.sizeFilter,
      builder: (context, state) {
        final controller = context.read<ProductReviewsController>();
        final rows = [
          if (colorNames.length > 1)
            _Row(
              label: loc.pdp_color,
              options: colorNames,
              selected: state.colorFilter,
              onAll: controller.clearColor,
              onPick: controller.toggleColor,
            ),
          if (sizes.length > 1)
            _Row(
              label: secondLabel,
              options: sizes,
              selected: state.sizeFilter,
              onAll: controller.clearSize,
              onPick: controller.toggleSize,
            ),
        ];
        if (rows.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) SdVerticalSpacingV5(value: SdSpacingV5.s8),
              rows[i],
            ],
          ],
        );
      },
    );
  }
}

/// "Color" then "All · Blush · Midnight …", scrolling sideways.
class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.options,
    required this.selected,
    required this.onAll,
    required this.onPick,
  });

  final String label;
  final List<String> options;
  final String? selected;
  final VoidCallback onAll;
  final ValueChanged<String> onPick;

  static const double _labelWidth = 64;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return SizedBox(
      height: SdSpacingV5.s36,
      child: Row(
        children: [
          SizedBox(
            width: _labelWidth,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: options.length + 1,
              separatorBuilder: (_, _) =>
                  SdHorizontalSpacingV5(value: SdSpacingV5.s8),
              itemBuilder: (context, i) => i == 0
                  ? AppChip(
                      label: context.loc.review_filter_all,
                      selected: selected == null,
                      onTap: onAll,
                    )
                  : AppChip(
                      label: options[i - 1],
                      selected: selected == options[i - 1],
                      onTap: () => onPick(options[i - 1]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
