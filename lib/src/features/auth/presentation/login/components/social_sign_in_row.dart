import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// "Or continue with" and the two vendor buttons. In the demo they explain
/// themselves instead of opening a vendor sheet.
class SocialSignInRow extends StatelessWidget {
  const SocialSignInRow({super.key});

  @override
  Widget build(BuildContext context) {
    void notice() => SdSnackBarUtilsV5.info(context, context.loc.login_social_demo);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(child: SdDividerV5()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SdSpacingConstant.w12),
              child: Text(
                context.loc.login_or,
                style: context.textTheme5.labelMedium!.faint5(context),
              ),
            ),
            const Expanded(child: SdDividerV5()),
          ],
        ),
        SizedBox(height: SdSpacingConstant.h16),
        Row(
          children: <Widget>[
            Expanded(
              child: SdButtonV5(
                variant: SdButtonVariantV5.outlined,
                label: 'Apple',
                icon: Symbols.ios_rounded,
                expand: true,
                onPressed: notice,
              ),
            ),
            SizedBox(width: SdSpacingConstant.w12),
            Expanded(
              child: SdButtonV5(
                variant: SdButtonVariantV5.outlined,
                label: 'Google',
                icon: Symbols.public_rounded,
                expand: true,
                onPressed: notice,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
