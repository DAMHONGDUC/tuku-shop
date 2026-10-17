import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/cart_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

/// One line of the bag. Swipe left to remove; the stepper takes it to zero
/// the same way.
class CartItemTile extends StatelessWidget {
  const CartItemTile({required this.item, super.key});

  final CartItemEntity item;

  void _remove(BuildContext context) {
    HapticFeedback.lightImpact();
    context.read<CartController>().remove(item.id);
    SdSnackBarUtilsV5.info(context, context.loc.cart_removed(item.name));
  }

  @override
  Widget build(BuildContext context) => Dismissible(
    key: ValueKey<String>('dismiss-${item.id}'),
    direction: DismissDirection.endToStart,
    onDismissed: (DismissDirection _) => _remove(context),
    background: Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: SdSpacingConstant.w24),
      decoration: BoxDecoration(
        color: context.sdTheme5.danger,
        borderRadius: SdRadiusV5.cardAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            context.loc.action_remove,
            style: context.textTheme5.labelLarge!.copyWith(color: Colors.white),
          ),
          SizedBox(width: SdSpacingConstant.w8),
          const SdIconV5(Symbols.delete_rounded, color: Colors.white),
        ],
      ),
    ),
    child: SdCardV5(
      padding: EdgeInsets.all(SdSpacingConstant.w12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SdPressableV5(
            onTap: () => context.push(AppRoutes.productPath(item.productId)),
            child: SizedBox(
              width: SdSpacingConstant.w64 * 1.35,
              height: SdSpacingConstant.w64 * 1.35 / 0.8,
              child: AppImage(item.image, borderRadius: SdRadiusV5.thumbnailAll),
            ),
          ),
          SizedBox(width: SdSpacingConstant.w14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme5.titleSmall,
                      ),
                    ),
                    SdIconButtonV5(
                      icon: Symbols.close_rounded,
                      tooltip: context.loc.action_remove,
                      size: SdSpacingConstant.r32,
                      color: context.sdTheme5.textTertiary,
                      onPressed: () => _remove(context),
                    ),
                  ],
                ),
                Text(
                  context.loc.review_variant(item.size, item.color),
                  style: context.textTheme5.bodySmall!.muted5(context),
                ),
                SizedBox(height: SdSpacingConstant.h10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SdPriceV5(
                        price: Formatters.currency(item.lineTotal),
                        compareAt: item.compareAtPrice == null
                            ? null
                            : Formatters.currency(item.compareAtPrice! * item.quantity),
                        size: SdPriceSizeV5.small,
                      ),
                    ),
                    SdQuantityStepperV5(
                      value: item.quantity,
                      min: 0,
                      max: 10,
                      compact: true,
                      decreaseTooltip: context.loc.action_decrease,
                      increaseTooltip: context.loc.action_increase,
                      onChanged: (int q) {
                        if (q == 0) {
                          _remove(context);
                          return;
                        }
                        context.read<CartController>().updateQuantity(item.id, q);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
