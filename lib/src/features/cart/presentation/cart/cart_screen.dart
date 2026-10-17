import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/cart_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

import 'components/cart_item_tile.dart';
import 'components/checkout_bar.dart';
import 'components/free_shipping_meter.dart';
import 'components/promo_code_field.dart';

/// The Bag tab.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CartController, CartEntity>(
    builder: (BuildContext context, CartEntity cart) => SdScaffoldV5(
      body: FadeSwitcher(
        child: cart.isEmpty ? const _EmptyBag() : _Bag(cart: cart),
      ),
    ),
  );
}

class _Bag extends StatelessWidget {
  const _Bag({required this.cart});

  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    final double barSpace =
        CheckoutBar.height + SdContentPaddingV5.aboveNavBar(context);

    return Stack(
      children: <Widget>[
        ListView(
          padding: SdContentPaddingV5.gutter.copyWith(
            top:
                SdContentPaddingV5.statusBarInset(context) +
                SdSpacingConstant.h16,
            bottom: barSpace + SdSpacingConstant.h16,
          ),
          children: <Widget>[
            Text(
              context.loc.cart_title,
              style: context.textTheme5.displaySmall,
            ),
            SizedBox(height: SdSpacingConstant.h4),
            Text(
              context.loc.cart_count(cart.itemCount),
              style: context.textTheme5.bodyMedium!.muted5(context),
            ),
            SizedBox(height: SdSpacingConstant.h16),
            FreeShippingMeter(cart: cart),
            SizedBox(height: SdSpacingConstant.h16),
            for (final (int i, CartItemEntity item) in cart.items.indexed)
              Padding(
                key: ValueKey<String>(item.id),
                padding: EdgeInsets.only(bottom: SdContentPaddingV5.itemGap),
                child: SdFadeInV5(
                  index: i,
                  child: CartItemTile(item: item),
                ),
              ),
            SizedBox(height: SdSpacingConstant.h8),
            PromoCodeField(promo: cart.promo),
            SizedBox(height: SdSpacingConstant.h16),
            OrderSummaryCard(
              subtotal: cart.subtotal,
              discount: cart.discount,
              shipping: cart.estimatedShipping,
              savings: cart.savings,
              total: cart.total,
              promoCode: cart.promo?.code,
            ),
          ],
        ),
        Positioned(
          left: SdContentPaddingV5.horizontal,
          right: SdContentPaddingV5.horizontal,
          bottom:
              SdContentPaddingV5.aboveNavBar(context) - SdSpacingConstant.h4,
          child: CheckoutBar(
            total: cart.total,
            onCheckout: () => context.push(AppRoutes.checkout.path),
          ),
        ),
      ],
    );
  }
}

class _EmptyBag extends StatelessWidget {
  const _EmptyBag();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: SdContentPaddingV5.aboveNavBar(context)),
    child: SdEmptyStateV5(
      icon: Symbols.shopping_bag_rounded,
      title: context.loc.cart_empty_title,
      message: context.loc.cart_empty_message,
      action: SdButtonV5(
        variant: SdButtonVariantV5.primary,
        label: context.loc.action_start_shopping,
        onPressed: () => context.go(AppRoutes.shop.path),
      ),
    ),
  );
}
