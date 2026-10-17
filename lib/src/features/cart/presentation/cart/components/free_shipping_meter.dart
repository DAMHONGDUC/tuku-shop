import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

/// How close the bag is to free shipping, as a bar that fills as items go in.
class FreeShippingMeter extends StatelessWidget {
  const FreeShippingMeter({required this.cart, super.key});

  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    final bool unlocked = cart.qualifiesForFreeShipping;
    final double progress = unlocked
        ? 1
        : (cart.subtotal / AppConstants.freeShippingThreshold).clamp(0, 1);
    final Color tint = unlocked
        ? context.sdTheme5.success
        : context.sdTheme5.textPrimary;

    return SdCardV5(
      layer: SdCardLayerV5.sunken,
      padding: EdgeInsets.all(SdSpacingConstant.w14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SdIconV5(
                unlocked
                    ? Symbols.celebration_rounded
                    : Symbols.local_shipping_rounded,
                size: SdIconV5.smallSize * 1.1,
                color: tint,
              ),
              SizedBox(width: SdSpacingConstant.w8),
              Expanded(
                child: AnimatedSwitcher(
                  duration: SdMotionV5.of(context, SdMotionV5.normal),
                  child: Text(
                    unlocked
                        ? context.loc.cart_free_shipping_unlocked
                        : context.loc.cart_free_shipping_more(
                            Formatters.currency(cart.amountToFreeShipping),
                          ),
                    key: ValueKey<bool>(unlocked),
                    style: context.textTheme5.labelLarge,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SdSpacingConstant.h10),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(end: progress),
            duration: SdMotionV5.of(context, SdMotionV5.slow),
            curve: SdMotionV5.standard,
            builder: (BuildContext context, double v, Widget? _) => ClipRRect(
              borderRadius: SdRadiusV5.fullAll,
              child: LinearProgressIndicator(
                value: v,
                minHeight: SdSpacingConstant.h6,
                color: tint,
                backgroundColor: context.sdTheme5.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
