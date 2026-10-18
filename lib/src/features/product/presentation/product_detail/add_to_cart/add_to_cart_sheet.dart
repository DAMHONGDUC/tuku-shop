import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_section.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_selection_controller.dart';

import 'add_to_cart_controller.dart';

/// Pick color, size and quantity, then add. Shares the page's selection, so
/// what was picked on the page is already selected here.
class AddToCartSheet extends StatelessWidget {
  const AddToCartSheet({
    super.key,
    required this.product,
    required this.buyNow,
  });

  final ProductEntity product;
  final bool buyNow;

  static Future<void> show(
    BuildContext context, {
    required ProductEntity product,
    required bool buyNow,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.colorTheme.cardDefault,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(UIConstants.sheetRadius),
        ),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<VariantSelectionController>()),
          BlocProvider.value(value: context.read<AddToCartController>()),
        ],
        child: AddToCartSheet(product: product, buyNow: buyNow),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BlocListener<AddToCartController, AddToCartState>(
      listenWhen: (a, b) => b.status == AddToCartStatus.added,
      listener: (context, _) => Navigator.of(context).pop(),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            SdSpacingV5.s16,
            SdSpacingV5.s12,
            SdSpacingV5.s16,
            SdSpacingV5.s16,
          ),
          child: BlocBuilder<VariantSelectionController, VariantSelectionState>(
            builder: (context, selection) {
              final selectedImage =
                  product.productColors
                      .where((c) => c.colorName == selection.colorName)
                      .firstOrNull
                      ?.imageUrl ??
                  product.imageUrl;
              final stock = selection.stock;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: SdSpacingV5.s40,
                      height: SdSpacingV5.s4,
                      decoration: BoxDecoration(
                        color: colors.borderDefault,
                        borderRadius: BorderRadius.circular(SdSpacingV5.s4),
                      ),
                    ),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  Row(
                    children: [
                      CatalogImage(
                        path: selectedImage,
                        width: 72,
                        height: 90,
                        borderRadius: UIConstants.imageRadius,
                      ),
                      SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: SdTextStyleV5.heading16().wColor(
                                colors.textDefault,
                              ),
                            ),
                            SdVerticalSpacingV5(value: SdSpacingV5.s4),
                            PriceText(
                              price: product.price,
                              originalPrice: product.originalPrice,
                            ),
                            SdVerticalSpacingV5(value: SdSpacingV5.s4),
                            Text(
                              stock == null
                                  ? context.loc.pdp_select_size
                                  : context.loc.sheet_in_stock(stock),
                              style: SdTextStyleV5.body12().wColor(
                                colors.textSubTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  VariantSection(product: product),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  Row(
                    children: [
                      Text(
                        context.loc.sheet_quantity,
                        style: SdTextStyleV5.body14().wColor(
                          colors.textSubTitle,
                        ),
                      ),
                      const Spacer(),
                      QuantityStepper(
                        value: selection.quantity,
                        max: selection.maxQuantity,
                        onChanged: (q) {
                          final controller = context
                              .read<VariantSelectionController>();
                          q > selection.quantity
                              ? controller.increment()
                              : controller.decrement();
                        },
                      ),
                    ],
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s24),
                  BlocBuilder<AddToCartController, AddToCartState>(
                    builder: (context, addState) {
                      final total = AppFormat.price(
                        product.price * selection.quantity,
                      );
                      return AppButton(
                        label: buyNow
                            ? context.loc.sheet_buy_now(total)
                            : context.loc.sheet_add_to_cart(total),
                        isLoading: addState.status == AddToCartStatus.adding,
                        onTap: selection.canAddToCart
                            ? () => context.read<AddToCartController>().add(
                                product: product,
                                colorName: selection.colorName!,
                                size: selection.size!,
                                quantity: selection.quantity,
                                buyNow: buyNow,
                              )
                            : null,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
