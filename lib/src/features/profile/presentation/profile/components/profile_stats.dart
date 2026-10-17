import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Two tappable counts: orders placed and pieces saved.
class ProfileStats extends StatelessWidget {
  const ProfileStats({
    required this.orderCount,
    required this.savedCount,
    required this.onOrders,
    required this.onSaved,
    super.key,
  });

  final int orderCount;
  final int savedCount;
  final VoidCallback onOrders;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Expanded(
        child: _Stat(
          value: orderCount,
          label: context.loc.profile_orders,
          onTap: onOrders,
        ),
      ),
      SizedBox(width: SdContentPaddingV5.gridGap),
      Expanded(
        child: _Stat(
          value: savedCount,
          label: context.loc.profile_saved,
          onTap: onSaved,
        ),
      ),
    ],
  );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.onTap});

  final int value;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SdCardV5(
    layer: SdCardLayerV5.outlined,
    onTap: onTap,
    semanticLabel: '$value $label',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('$value', style: context.textTheme5.headlineSmall),
        SizedBox(height: SdSpacingConstant.h2),
        Text(label, style: context.textTheme5.bodySmall!.muted5(context)),
      ],
    ),
  );
}
