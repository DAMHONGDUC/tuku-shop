import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:system_design/index.dart';

class Helper {
  static getSdButtonColorConfig(BuildContext context) =>
      SdButtonColorConfigV5.init().copyWith(
        primaryBgColor: context.colorTheme.primary,
        secondaryTextColor: context.colorTheme.textDefault,
        secondaryBorderColor: context.colorTheme.borderDefault,
      );
}
