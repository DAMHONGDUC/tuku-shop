abstract final class AppConstants {
  static const String appName = 'Tuku Shop';

  /// Shown in Settings. Keep in step with `version:` in pubspec.yaml.
  static const String appVersion = '1.0.0';

  /// The lower-case wordmark drawn on the splash and sign-in screens.
  static const String wordmark = 'tuku';

  /// Orders at or above this subtotal ship free.
  static const double freeShippingThreshold = 75;

  /// How many products one page of a grid asks for.
  static const int pageSize = 10;

  /// The design frame every screenutil dimension is measured against.
  static const double designWidth = 390;
  static const double designHeight = 844;
}
