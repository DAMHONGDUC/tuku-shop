import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_design/index.dart';

import 'app_colors.dart';

/// Builds the app's [ThemeData]. Called inside `ScreenUtilInit`, because
/// every font size is measured in `.sp`.
abstract final class AppTheme {
  static const String bodyFont = 'Plus Jakarta Sans';

  /// The editorial serif, for display and headline styles only.
  static const String displayFont = 'Playfair Display';

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final SdThemeV5 palette = isDark ? AppColors.dark : AppColors.light;
    final ColorScheme scheme = AppColors.scheme(brightness);
    final TextTheme text = _textTheme(palette.textPrimary);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: bodyFont,
      textTheme: text,
      scaffoldBackgroundColor: palette.background,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      dividerColor: palette.divider,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: palette.textPrimary,
        selectionColor: palette.textPrimary.withValues(alpha: 0.18),
        selectionHandleColor: palette.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      extensions: <ThemeExtension<dynamic>>[palette],
    );
  }

  static TextTheme _textTheme(Color color) {
    TextStyle display(double size, {FontWeight weight = FontWeight.w600}) =>
        TextStyle(
          fontFamily: displayFont,
          fontSize: size.sp,
          fontWeight: weight,
          height: 1.15,
          letterSpacing: -0.3,
          color: color,
        );
    TextStyle body(
      double size, {
      FontWeight weight = FontWeight.w400,
      double height = 1.45,
      double spacing = 0,
    }) => TextStyle(
      fontFamily: bodyFont,
      fontSize: size.sp,
      fontWeight: weight,
      height: height,
      letterSpacing: spacing,
      color: color,
    );

    return TextTheme(
      displayLarge: display(40, weight: FontWeight.w700),
      displayMedium: display(34),
      displaySmall: display(28),
      headlineLarge: display(26),
      headlineMedium: display(23),
      headlineSmall: body(22, weight: FontWeight.w700, height: 1.25),
      titleLarge: body(18, weight: FontWeight.w700, height: 1.3, spacing: -0.2),
      titleMedium: body(16, weight: FontWeight.w600, height: 1.35),
      titleSmall: body(14, weight: FontWeight.w600, height: 1.35),
      bodyLarge: body(15),
      bodyMedium: body(14),
      bodySmall: body(12.5),
      labelLarge: body(14, weight: FontWeight.w600, height: 1.2),
      labelMedium: body(12, weight: FontWeight.w500, height: 1.2),
      labelSmall: body(11, weight: FontWeight.w500, height: 1.2, spacing: 0.2),
    );
  }
}
