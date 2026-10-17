import 'package:system_design/index.dart';

class AppFormat {
  const AppFormat._();

  /// `$69.00`: two decimals, so prices line up in lists.
  static String price(num value) =>
      SdCurrencyFormatHelperV5.formatPrice(value, decimalDigits: 2);
}
