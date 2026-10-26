import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'app_colors.dart';
import 'custom_theme_ext/app_color_theme_ext.dart';
import 'custom_theme_ext/app_text_theme_ext.dart';

class AppTheme {
  static ThemeData buildLightTheme() => _build(
    AppColorThemeExt.light(),
    AppTextThemeExt.light(),
    Brightness.light,
  );

  static ThemeData buildDarkTheme() =>
      _build(AppColorThemeExt.dark(), AppTextThemeExt.dark(), Brightness.dark);

  /// Material defaults (snackbars, dialogs, sheets, app bars, tabs) follow
  /// the app palette, so screens never restyle them one by one.
  static ThemeData _build(
    AppColorThemeExt colors,
    AppTextThemeExt text,
    Brightness brightness,
  ) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: colors.primary,
          brightness: brightness,
        ).copyWith(
          primary: colors.primary,
          onPrimary: colors.onPrimary,
          secondary: colors.accent,
          surface: colors.cardDefault,
          onSurface: colors.textDefault,
          error: colors.sale,
          outline: colors.borderDefault,
          outlineVariant: colors.borderDefault,
        );
    final baseTheme = ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.pageDefault,
    );
    const radius = BorderRadius.all(Radius.circular(SdSpacingV5.s16));

    return baseTheme.copyWith(
      textTheme: _nativeTracking(baseTheme.textTheme),
      dividerColor: colors.borderDefault,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.pageDefault,
        foregroundColor: colors.textDefault,
        surfaceTintColor: SdColorsV5.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.textDefault,
        contentTextStyle: SdTextStyleV5.body14().wColor(colors.pageDefault),
        // The snackbar inverts the page, so its action takes the champagne
        // that reads on the inverted fill.
        actionTextColor: brightness == Brightness.light
            ? AppColors.champagneLight
            : AppColors.champagne,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(SdSpacingV5.s12)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.cardDefault,
        surfaceTintColor: SdColorsV5.transparent,
        shape: const RoundedRectangleBorder(borderRadius: radius),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.cardDefault,
        surfaceTintColor: SdColorsV5.transparent,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.primary),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
        selectionHandleColor: colors.primary,
        selectionColor: colors.accentSoft,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colors.textDefault),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: colors.textDefault,
        unselectedLabelColor: colors.textSubTitle,
        indicatorColor: colors.textDefault,
        dividerColor: colors.borderDefault,
      ),
      extensions: [colors, text],
    );
  }

  /// Material's type scale adds 0.1–0.5 letter spacing; the platform font
  /// reads like native apps (and Shopee) at 0.
  static TextTheme _nativeTracking(TextTheme t) {
    TextStyle? zero(TextStyle? s) => s?.copyWith(letterSpacing: 0);
    return t.copyWith(
      displayLarge: zero(t.displayLarge),
      displayMedium: zero(t.displayMedium),
      displaySmall: zero(t.displaySmall),
      headlineLarge: zero(t.headlineLarge),
      headlineMedium: zero(t.headlineMedium),
      headlineSmall: zero(t.headlineSmall),
      titleLarge: zero(t.titleLarge),
      titleMedium: zero(t.titleMedium),
      titleSmall: zero(t.titleSmall),
      bodyLarge: zero(t.bodyLarge),
      bodyMedium: zero(t.bodyMedium),
      bodySmall: zero(t.bodySmall),
      labelLarge: zero(t.labelLarge),
      labelMedium: zero(t.labelMedium),
      labelSmall: zero(t.labelSmall),
    );
  }
}
