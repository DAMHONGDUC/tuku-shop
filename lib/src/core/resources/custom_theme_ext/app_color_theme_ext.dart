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
  final Color sale;
  final Color success;
  final Color warning;

  /// Brand at low opacity: secondary buttons, chips, highlighted cards.
  final Color primarySoft;

  /// Text and icons drawn on a [primary] fill.
  final Color onPrimary;

  /// Champagne: membership, ratings, editorial highlights. Never a CTA.
  final Color accent;

  /// [accent] at low opacity, for tinted badges and cards.
  final Color accentSoft;

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
    required this.sale,
    required this.success,
    required this.warning,
    required this.primarySoft,
    required this.onPrimary,
    required this.accent,
    required this.accentSoft,
  });

  // Light theme: ivory page, white cards, ink CTAs, champagne accents.
  // Palette documented in docs/full-shop-flow-plan.md ("Premium refresh").
  static AppColorThemeExt light() {
    const shadow = Color(0xFF3A2E1E);
    return AppColorThemeExt(
      pageDefault: AppColors.pageDefaultLight,
      textDefault: AppColors.textDefaultLight,
      iconDefault: AppColors.iconDefaultLight,
      iconSecondary: AppColors.textSubTitleLight,
      textSubTitle: AppColors.textSubTitleLight,
      cardDefault: AppColors.cardDefaultLight,
      boxShadowDefault: shadow.withValues(alpha: 0.08),
      borderDefault: const Color(0xFFE7E1D8),
      indicatorActive: AppColors.primary,
      indicatorBg: AppColors.inkSoft.withValues(alpha: 0.25),
      primary: AppColors.primary,
      surfaceDefault: AppColors.white,
      primaryShadowDefault: AppColors.primary.withValues(alpha: 0.18),
      cardOnSurface: AppColors.pageSecondaryLight,
      boxShadowSecondary: shadow.withValues(alpha: 0.05),
      sale: const Color(0xFFB3261E),
      success: const Color(0xFF2F7A57),
      warning: const Color(0xFFC8962E),
      primarySoft: AppColors.primary.withValues(alpha: 0.05),
      onPrimary: AppColors.white,
      accent: AppColors.champagne,
      accentSoft: AppColors.champagne.withValues(alpha: 0.12),
    );
  }

  // Dark theme: espresso page, champagne CTAs with ink text.
  static AppColorThemeExt dark() {
    const primary = AppColors.champagneLight;
    return AppColorThemeExt(
      pageDefault: const Color(0xFF0F0E0D),
      textDefault: AppColors.textDefaultDark,
      iconDefault: const Color(0xFFE8E3DA),
      iconSecondary: const Color(0xFFA39C92),
      textSubTitle: const Color(0xFFA39C92),
      cardDefault: const Color(0xFF1A1917),
      boxShadowDefault: SdColorsV5.black.withValues(alpha: 0.4),
      borderDefault: const Color(0xFF2C2A27),
      indicatorActive: primary,
      indicatorBg: const Color(0xFFA39C92).withValues(alpha: 0.3),
      primary: primary,
      surfaceDefault: const Color(0xFF1A1917),
      primaryShadowDefault: primary.withValues(alpha: 0.2),
      cardOnSurface: const Color(0xFF23211F),
      boxShadowSecondary: SdColorsV5.black.withValues(alpha: 0.3),
      sale: const Color(0xFFE5626B),
      success: const Color(0xFF5CC291),
      warning: const Color(0xFFE7B95A),
      primarySoft: primary.withValues(alpha: 0.1),
      onPrimary: AppColors.ink,
      accent: primary,
      accentSoft: primary.withValues(alpha: 0.14),
    );
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
