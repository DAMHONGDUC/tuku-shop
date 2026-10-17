import 'package:intl/intl.dart';

/// Money and dates, formatted the one way the app shows them.
abstract final class Formatters {
  static final NumberFormat _money = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 2,
  );

  /// `$38.99`. The store prices in USD whatever the UI language.
  static String currency(double value) => _money.format(value);

  /// `−30%` for a [price] marked down from [compareAt].
  static String discount(double price, double compareAt) =>
      '-${((1 - price / compareAt) * 100).round()}%';

  /// `12 Oct 2026` in the UI language.
  static String date(DateTime value, String locale) =>
      DateFormat.yMMMd(locale).format(value);

  /// `12 Oct, 14:05`.
  static String dateTime(DateTime value, String locale) =>
      DateFormat('d MMM, HH:mm', locale).format(value);

  /// `14:05`.
  static String time(DateTime value, String locale) =>
      DateFormat.Hm(locale).format(value);

  /// `1.2k` above a thousand.
  static String compact(int value) =>
      NumberFormat.compact(locale: 'en_US').format(value);
}
