import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

import '../app_colors.dart';

class AppColorThemeExt extends ThemeExtension<AppColorThemeExt> {
  final Color pageDefault;
  final Color textDefault;
  final Color iconDefault;
  final Color iconSecondary;
  final Color textSubTitle;
  final Color cardDefault;
  final Color boxShadowDefault;
  final Color borderDefault;
  final Color indicatorActive;
  final Color indicatorBg;
  final Color primary;
  final Color surfaceDefault;
  final Color primaryShadowDefault;
  final Color cardOnSurface;
  final Color boxShadowSecondary;

  const AppColorThemeExt({
    required this.pageDefault,
    required this.textDefault,
    required this.iconDefault,
    required this.iconSecondary,
    required this.textSubTitle,
    required this.cardDefault,
    required this.boxShadowDefault,
    required this.borderDefault,
    required this.indicatorActive,
    required this.indicatorBg,
    required this.primary,
    required this.surfaceDefault,
    required this.primaryShadowDefault,
    required this.cardOnSurface,
    required this.boxShadowSecondary,
  });

  // Light theme
  static AppColorThemeExt light() {
    return AppColorThemeExt(
      pageDefault: Color(0xFFf1f1f1),
      textDefault: AppColors.textDefaultLight,
      iconDefault: AppColors.iconDefaultLight,
      iconSecondary: SdColorsV5.grey.withValues(alpha: 0.9),
      textSubTitle: AppColors.textSubTitleLight,
      cardDefault: AppColors.cardDefaultLight,
      boxShadowDefault: SdColorsV5.black.withValues(alpha: 0.15),
      borderDefault: Color(0xFFe6e7eb),
      indicatorActive: AppColors.primary,
      indicatorBg: SdColorsV5.grey.withValues(alpha: 0.3),
      primary: AppColors.primary,
      surfaceDefault: AppColors.white,
      primaryShadowDefault: AppColors.primary.withValues(alpha: 0.2),
      cardOnSurface: Color(0xFFf1f1f1),
      boxShadowSecondary: SdColorsV5.black.withValues(alpha: 0.1),
    );
  }

  // Dark theme
  // TODO: create color for dark theme
  // for now it's have same value with light
  static AppColorThemeExt dark() {
    return AppColorThemeExt.light();
  }

  @override
  ThemeExtension<AppColorThemeExt> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppColorThemeExt> lerp(
    covariant ThemeExtension<AppColorThemeExt>? other,
    double t,
  ) {
    return this;
  }

  // @override
  // ThemeExtension<AppColorThemeExt> copyWith({
  //   Color? bgPrimary,
  //   Color? textTitle,
  //   Color? iconPrimary,
  //   Color? textSubTitle,
  //   Color? cardBg,
  //   Color? boxShadowDefault,
  // }) {
  //   return AppColorThemeExt(
  //     pageDefault: bgPrimary ?? pageDefault,
  //     textDefault: textTitle ?? textDefault,
  //     iconDefault: iconPrimary ?? iconDefault,
  //     textSubTitle: textSubTitle ?? this.textSubTitle,
  //     cardDefault: cardBg ?? cardDefault,
  //     boxShadowDefault: boxShadowDefault ?? this.boxShadowDefault,
  //   );
  // }

  // @override
  // ThemeExtension<AppColorThemeExt> lerp(
  //   covariant ThemeExtension<AppColorThemeExt>? other,
  //   double t,
  // ) {
  //   if (other is! AppColorThemeExt) return this;

  //   return AppColorThemeExt(
  //     pageDefault: Color.lerp(pageDefault, other.pageDefault, t) ?? pageDefault,
  //     textDefault: Color.lerp(textDefault, other.textDefault, t) ?? textDefault,
  //     iconDefault: Color.lerp(iconDefault, other.iconDefault, t) ?? iconDefault,
  //     textSubTitle:
  //         Color.lerp(textSubTitle, other.textSubTitle, t) ?? textSubTitle,
  //     cardDefault: Color.lerp(cardDefault, other.cardDefault, t) ?? cardDefault,
  //     boxShadowDefault:
  //         Color.lerp(boxShadowDefault, other.boxShadowDefault, t) ??
  //         boxShadowDefault,
  //   );
  // }
}
