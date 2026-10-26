import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

/// Raw palette: white page, soft grey cards, ink type, champagne accent.
/// Screens read the themed roles in `context.colorTheme`, never these.
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

  // Champagne accent
  static const Color champagne = Color(0xFFA8834A);
  static const Color champagneLight = Color(0xFFD9BF8C);

  // Primary Brand
  static const Color primary = ink;

  // Light
  static const Color textDefaultLight = ink;
  static const Color textSubTitleLight = inkSoft;
  static const Color cardDefaultLight = mist;
  static const Color pageDefaultLight = white;
  static const Color pageSecondaryLight = cloud;
  static const Color iconDefaultLight = Color(0xFF1E1E1E);

  // Dark
  static const Color textDefaultDark = Color(0xFFF4F0E8);
}
