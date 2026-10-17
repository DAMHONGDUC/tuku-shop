import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The member's loyalty balance.
class PointsCard extends StatelessWidget {
  const PointsCard({required this.points, super.key});

  final int points;

  @override
  Widget build(BuildContext context) => SdCardV5(
    layer: SdCardLayerV5.sunken,
    child: Row(
      children: <Widget>[
        SdIconV5(
          Symbols.stars_rounded,
          color: context.sdTheme5.rating,
          fill: 1,
        ),
        SizedBox(width: SdSpacingConstant.w12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                context.loc.profile_points_title,
                style: context.textTheme5.titleSmall,
              ),
              SizedBox(height: SdSpacingConstant.h2),
              Text(
                context.loc.profile_points_hint,
                style: context.textTheme5.bodySmall!.muted5(context),
              ),
            ],
          ),
        ),
        SizedBox(width: SdSpacingConstant.w8),
        Text(
          context.loc.profile_points_value(points),
          style: context.textTheme5.titleLarge,
        ),
      ],
    ),
  );
}
