import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Three promises in a row: free shipping, returns, secure checkout.
class PerksStrip extends StatelessWidget {
  const PerksStrip({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: SdContentPaddingV5.gutter,
    child: SdCardV5(
      layer: SdCardLayerV5.sunken,
      padding: EdgeInsets.symmetric(
        vertical: SdSpacingConstant.h12,
        horizontal: SdSpacingConstant.w8,
      ),
      child: Row(
        children: <Widget>[
          _Perk(icon: Symbols.local_shipping_rounded, label: context.loc.perk_shipping),
          _Perk(icon: Symbols.autorenew_rounded, label: context.loc.perk_returns),
          _Perk(icon: Symbols.verified_user_rounded, label: context.loc.perk_secure),
        ],
      ),
    ),
  );
}

class _Perk extends StatelessWidget {
  const _Perk({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: <Widget>[
        SdIconV5(icon, size: SdIconV5.defaultSize),
        SizedBox(height: SdSpacingConstant.h4),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: context.textTheme5.labelSmall!.muted5(context),
        ),
      ],
    ),
  );
}
