import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Four bars that fill and warm up as the password gets stronger, with the
/// verdict in words beside them.
class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({required this.strength, super.key});

  /// 0–4.
  final int strength;

  @override
  Widget build(BuildContext context) {
    final (String label, Color color) = switch (strength) {
      0 || 1 => (context.loc.password_weak, context.sdTheme5.danger),
      2 => (context.loc.password_fair, context.sdTheme5.warning),
      3 => (context.loc.password_good, context.sdTheme5.info),
      _ => (context.loc.password_strong, context.sdTheme5.success),
    };

    return Row(
      children: <Widget>[
        for (int i = 0; i < 4; i++) ...<Widget>[
          if (i > 0) SizedBox(width: SdSpacingConstant.w4),
          Expanded(
            child: AnimatedContainer(
              duration: SdMotionV5.of(context, SdMotionV5.normal),
              height: SdSpacingConstant.h4,
              decoration: BoxDecoration(
                color: i < strength ? color : context.sdTheme5.surfaceSunken,
                borderRadius: SdRadiusV5.fullAll,
              ),
            ),
          ),
        ],
        SizedBox(width: SdSpacingConstant.w12),
        AnimatedSwitcher(
          duration: SdMotionV5.of(context, SdMotionV5.fast),
          child: Text(
            strength == 0 ? '' : label,
            key: ValueKey<int>(strength),
            style: context.textTheme5.labelMedium!.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
