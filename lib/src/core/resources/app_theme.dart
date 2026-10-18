import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_theme_ext/app_color_theme_ext.dart';
import 'custom_theme_ext/app_text_theme_ext.dart';

class AppTheme {
  static ThemeData buildLightTheme() {
    final colors = AppColorThemeExt.light();
    final baseTheme = ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: colors.primary,
      scaffoldBackgroundColor: colors.pageDefault,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
      extensions: [colors, AppTextThemeExt.light()],
    );
  }

  static ThemeData buildDarkTheme() {
    final colors = AppColorThemeExt.dark();
    final baseTheme = ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: colors.primary,
      scaffoldBackgroundColor: colors.pageDefault,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
      extensions: [colors, AppTextThemeExt.dark()],
    );
  }
}
