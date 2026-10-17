import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The total and "Checkout", floating just above the tab bar.
class CheckoutBar extends StatelessWidget {
  const CheckoutBar({required this.total, required this.onCheckout, super.key});

  final double total;
  final VoidCallback onCheckout;

  static double get height => SdSpacingConstant.h64 + SdSpacingConstant.h8;

  @override
  Widget build(BuildContext context) => SdCardV5(
    elevated: true,
    padding: EdgeInsets.fromLTRB(
      SdSpacingConstant.w20,
      SdSpacingConstant.h10,
      SdSpacingConstant.w12,
      SdSpacingConstant.h10,
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(context.loc.summary_total, style: context.textTheme5.labelMedium!.muted5(context)),
              Text(Formatters.currency(total), style: context.textTheme5.titleLarge!.tabular5),
            ],
          ),
        ),
        SdButtonV5(
          variant: SdButtonVariantV5.primary,
          label: context.loc.cart_checkout,
          trailingIcon: Symbols.arrow_forward_rounded,
          onPressed: onCheckout,
        ),
      ],
    ),
  );
}
