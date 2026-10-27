import 'package:system_design/index.dart';

class AppFormat {
  const AppFormat._();

  /// `$69.00`: two decimals, so prices line up in lists.
  static String price(num value) =>
      SdCurrencyFormatHelperV5.formatPrice(value, decimalDigits: 2);

  /// `940`, `1.2k`, `12k`: counts on product cards.
  static String compactCount(int value) {
    if (value < 1000) return '$value';
    final thousands = value / 1000;
    final text = thousands >= 10
        ? thousands.round().toString()
        : thousands.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
    return '${text}k';
  }
}
