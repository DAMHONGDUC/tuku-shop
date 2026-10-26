import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorites_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/add_to_cart/add_to_cart_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/add_to_cart/add_to_cart_sheet.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_selection_controller.dart';

/// Heart, Buy now and Add to cart: the product page's bottom actions, also
/// kept on the reviews screen. Needs the page's [AddToCartController] and
/// [VariantSelectionController] above it.
class ProductActionDock extends StatelessWidget {
  const ProductActionDock({super.key, required this.product});

  final ProductEntity product;

  void _addToCart(BuildContext context, {required bool buyNow}) {
    AddToCartSheet.show(context, product: product, buyNow: buyNow);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BottomActionBar(
      child: Row(
        children: [
          if (product.sellerId.isNotEmpty) ...[
            AppIconButton(
              icon: Icons.chat_bubble_outline_rounded,
              label: context.loc.pdp_chat,
              style: AppIconButtonStyle.outlined,
              onTap: () =>
                  context.push(ChatRoutes.threadLocation(product.sellerId)),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s8),
          ],
          BlocSelector<FavoritesController, FavoritesState, bool>(
            selector: (state) => state.contains(product.id),
            builder: (context, isFavorite) => AppIconButton(
              icon: isFavorite ? Icons.favorite : Icons.favorite_border,
              iconColor: isFavorite ? colors.sale : colors.textDefault,
              label: context.loc.wishlist_title,
              style: AppIconButtonStyle.outlined,
              onTap: () =>
                  context.read<FavoritesController>().toggle(product.id),
            ),
          ),
          SdHorizontalSpacingV5(value: SdSpacingV5.s12),
          Expanded(
            child: AppButton(
              label: context.loc.pdp_buy_now,
              style: AppButtonStyle.soft,
              onTap: product.isInStock
                  ? () => _addToCart(context, buyNow: true)
                  : null,
            ),
          ),
          SdHorizontalSpacingV5(value: SdSpacingV5.s12),
          Expanded(
            child: AppButton(
              label: product.isInStock
                  ? context.loc.pdp_add_to_cart
                  : context.loc.pdp_sold_out,
              onTap: product.isInStock
                  ? () => _addToCart(context, buyNow: false)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
