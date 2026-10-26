import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

/// Raw palette: white page, soft grey cards, ink type and the brand purple
/// of the app icon. Screens read the themed roles in `context.colorTheme`,
/// never these.
class AppColors {
  // Gray
  static const Color grey = SdColorsV5.grey;

  // Whites
  static const Color white = SdColorsV5.white;
  static const Color mist = Color(0xFFF6F6F8);
  static const Color cloud = Color(0xFFEFEFF2);

  // Ink
  static const Color ink = Color(0xFF141414);
  static const Color inkSoft = Color(0xFF6E6E73);

  // Brand purple, sampled from assets/images/app_icon.png. The native
  // launch screens (android/.../values/colors.xml, pubspec
  // background_color_ios) use [brand] too; keep them in step by hand.
  static const Color brand = Color(0xFF504EB7);
  static const Color brandLight = Color(0xFF6466D4);
  static const Color brandDeep = Color(0xFF3F3C9E);

  /// [brand] lifted for dark backgrounds.
  static const Color brandOnDark = Color(0xFF8583EE);

  // Primary Brand
  static const Color primary = brand;

  // Light
  static const Color textDefaultLight = ink;
  static const Color textSubTitleLight = inkSoft;
  static const Color cardDefaultLight = mist;
  static const Color pageDefaultLight = white;
  static const Color pageSecondaryLight = cloud;
  static const Color iconDefaultLight = Color(0xFF1E1E1E);

  // Dark
  static const Color textDefaultDark = Color(0xFFF2F2F7);
}
