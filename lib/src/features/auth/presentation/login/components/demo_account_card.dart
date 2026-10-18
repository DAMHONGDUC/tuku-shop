import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

class DemoAccountCard extends StatelessWidget {
  const DemoAccountCard({super.key, required this.onUse});

  final VoidCallback onUse;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return SdInkWellV5(
      onTap: onUse,
      containerBg: colors.primary.withValues(alpha: 0.08),
      borderRadius: SdSpacingV5.s12,
      contentPadding: EdgeInsets.all(SdSpacingV5.s12),
      child: Row(
        children: [
          SdIconV5(iconData: Icons.info_outline, color: colors.primary),
          SdHorizontalSpacingV5(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.loc.login_demo_title,
                  style: SdTextStyleV5.body12().wSemiBold().copyWith(
                    color: colors.primary,
                  ),
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s2),
                Text(
                  '${DemoAccount.email}  ·  ${DemoAccount.password}',
                  style: SdTextStyleV5.body12().copyWith(
                    color: colors.textDefault,
                  ),
                ),
              ],
            ),
          ),
          Text(
            context.loc.login_demo_fill,
            style: SdTextStyleV5.body12().wSemiBold().copyWith(
              color: colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
