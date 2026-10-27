import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_section.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_selection_controller.dart';

import 'add_to_cart_controller.dart';

/// Pick color, size and quantity, then add. Shares the page's selection, so
/// what was picked on the page is already selected here. An add (not Buy
/// now) flies the photo into the page's cart button as the sheet closes.
class AddToCartSheet extends StatefulWidget {
  const AddToCartSheet({
    super.key,
    required this.product,
    required this.buyNow,
    required this.onAdded,
  });

  final ProductEntity product;
  final bool buyNow;

  /// Where the photo was on screen, and which photo, once added.
  final void Function(Rect from, String imagePath) onAdded;

  static Future<void> show(
    BuildContext context, {
    required ProductEntity product,
    required bool buyNow,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.colorTheme.surfaceDefault,
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
        child: AddToCartSheet(
          product: product,
          buyNow: buyNow,
          // The page's context, so the photo lands on its cart button.
          onAdded: (from, imagePath) =>
              FlyToCart.launch(context, from: from, imagePath: imagePath),
        ),
      ),
    );
  }

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  final _imageKey = GlobalKey();

  ProductEntity get product => widget.product;
  bool get buyNow => widget.buyNow;

  String _imageFor(String? colorName) =>
      product.productColors
          .where((c) => c.colorName == colorName)
          .firstOrNull
          ?.imageUrl ??
      product.imageUrl;

  void _onAdded(AddToCartState state) {
    final box = _imageKey.currentContext?.findRenderObject();
    if (!state.buyNow && box is RenderBox && box.hasSize) {
      widget.onAdded(
        box.localToGlobal(Offset.zero) & box.size,
        _imageFor(context.read<VariantSelectionController>().state.colorName),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BlocListener<AddToCartController, AddToCartState>(
      listenWhen: (a, b) => b.status == AddToCartStatus.added,
      listener: (context, state) => _onAdded(state),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            SdSpacingV5.s16,
            SdSpacingV5.s12,
            SdSpacingV5.s16,
            BottomActionBar.bottomGap(context),
          ),
          child: BlocBuilder<VariantSelectionController, VariantSelectionState>(
            builder: (context, selection) {
              final selectedImage = _imageFor(selection.colorName);
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
                        key: _imageKey,
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
                                  ? (product.secondOption ==
                                            ProductOptionKind.model
                                        ? context.loc.pdp_select_model
                                        : context.loc.pdp_select_size)
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
