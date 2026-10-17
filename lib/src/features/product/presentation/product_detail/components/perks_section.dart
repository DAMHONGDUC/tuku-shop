import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Delivery and returns at a glance, under the variant pickers.
class PerksSection extends StatelessWidget {
  const PerksSection({super.key});

  @override
  Widget build(BuildContext context) => SdCardV5(
    layer: SdCardLayerV5.sunken,
    padding: EdgeInsets.zero,
    child: Column(
      children: <Widget>[
        SdListTileV5(
          icon: Symbols.local_shipping_rounded,
          title: context.loc.detail_perk_shipping,
          subtitle: context.loc.detail_perk_shipping_sub,
        ),
        SdDividerV5(indent: SdSpacingConstant.w64 + SdSpacingConstant.w6),
        SdListTileV5(
          icon: Symbols.autorenew_rounded,
          title: context.loc.detail_perk_returns,
          subtitle: context.loc.detail_perk_returns_sub,
        ),
      ],
    ),
  );
}
