import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../product_detail_controller.dart';
import 'size_guide_sheet.dart';

/// Colour swatches, size chips and quantity.
class VariantSection extends StatelessWidget {
  const VariantSection({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDetailController, ProductDetailState>(
        builder: (BuildContext context, ProductDetailState state) {
          final ProductEntity product = state.product!;
          final ProductDetailController controller = context
              .read<ProductDetailController>();
          final TextStyle label = context.textTheme5.titleSmall!;
          final TextStyle value = context.textTheme5.bodyMedium!.muted5(context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text.rich(
                TextSpan(
                  text: '${context.loc.detail_color}: ',
                  style: label,
                  children: <InlineSpan>[
                    TextSpan(text: state.color?.name ?? '', style: value),
                  ],
                ),
              ),
              SizedBox(height: SdSpacingConstant.h10),
              Wrap(
                spacing: SdSpacingConstant.w8,
                children: <Widget>[
                  for (final (int i, ProductColor c) in product.colors.indexed)
                    SdColorSwatchV5(
                      color: hexColor(c.hex),
                      semanticLabel: c.name,
                      selected: i == state.colorIndex,
                      onSelected: () => controller.selectColor(i),
                    ),
                ],
              ),
              SizedBox(height: SdSpacingConstant.h20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '${context.loc.detail_size}: ',
                        style: label,
                        children: <InlineSpan>[
                          TextSpan(
                            text: state.size ?? context.loc.detail_size_pick,
                            style: state.size == null
                                ? value.copyWith(color: context.sdTheme5.accent)
                                : value,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (product.sizes.length > 1)
                    SdButtonV5(
                      variant: SdButtonVariantV5.text,
                      size: SdButtonSizeV5.small,
                      label: context.loc.detail_size_guide,
                      onPressed: () => showSizeGuide(context, product),
                    ),
                ],
              ),
              SizedBox(height: SdSpacingConstant.h10),
              Shake(
                trigger: state.sizeNudge,
                child: Wrap(
                  spacing: SdSpacingConstant.w8,
                  runSpacing: SdSpacingConstant.h8,
                  children: <Widget>[
                    for (final String size in product.sizes)
                      SdChipV5(
                        label: size,
                        minWidth: SdSpacingConstant.w56,
                        selected: size == state.size,
                        onSelected: () => controller.selectSize(size),
                      ),
                  ],
                ),
              ),
              SizedBox(height: SdSpacingConstant.h20),
              Row(
                children: <Widget>[
                  Expanded(child: Text(context.loc.detail_quantity, style: label)),
                  SdQuantityStepperV5(
                    value: state.quantity,
                    max: 10,
                    decreaseTooltip: context.loc.action_decrease,
                    increaseTooltip: context.loc.action_increase,
                    onChanged: controller.setQuantity,
                  ),
                ],
              ),
            ],
          );
        },
      );
}
