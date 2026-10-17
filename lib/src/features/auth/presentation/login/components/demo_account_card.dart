import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

/// Tells a reviewer the form is already filled with a working test account.
class DemoAccountCard extends StatelessWidget {
  const DemoAccountCard({required this.demo, required this.onFill, super.key});

  final DemoAccount demo;
  final VoidCallback onFill;

  @override
  Widget build(BuildContext context) => SdCardV5(
    layer: SdCardLayerV5.sunken,
    padding: EdgeInsets.all(SdSpacingConstant.w12),
    child: Row(
      children: <Widget>[
        Container(
          width: SdSpacingConstant.r36,
          height: SdSpacingConstant.r36,
          decoration: BoxDecoration(
            color: context.sdTheme5.info.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SdIconV5(
              Symbols.science_rounded,
              size: SdIconV5.smallSize,
              color: context.sdTheme5.info,
            ),
          ),
        ),
        SizedBox(width: SdSpacingConstant.w12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                context.loc.login_demo_title,
                style: context.textTheme5.labelLarge!.semiBold5,
              ),
              SizedBox(height: SdSpacingConstant.h2),
              Text(
                '${demo.email}  ·  ${demo.password}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme5.bodySmall!.muted5(context).tabular5,
              ),
            ],
          ),
        ),
        SdButtonV5(
          variant: SdButtonVariantV5.secondary,
          size: SdButtonSizeV5.small,
          label: context.loc.login_demo_fill,
          onPressed: onFill,
        ),
      ],
    ),
  );
}
