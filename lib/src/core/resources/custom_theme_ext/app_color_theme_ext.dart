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
  });

  // Light theme
  // Palette from docs/design/tuku-shop-mockups.html.
  static AppColorThemeExt light() {
    return AppColorThemeExt(
      pageDefault: const Color(0xFFF4F4F7),
      textDefault: const Color(0xFF15151A),
      iconDefault: const Color(0xFF2A2A33),
      iconSecondary: const Color(0xFF6B6B78),
      textSubTitle: const Color(0xFF6B6B78),
      cardDefault: AppColors.white,
      boxShadowDefault: const Color(0xFF28265A).withValues(alpha: 0.08),
      borderDefault: const Color(0xFFE6E6EE),
      indicatorActive: AppColors.primary,
      indicatorBg: const Color(0xFF6B6B78).withValues(alpha: 0.25),
      primary: AppColors.primary,
      surfaceDefault: AppColors.white,
      primaryShadowDefault: AppColors.primary.withValues(alpha: 0.2),
      cardOnSurface: const Color(0xFFF4F4F7),
      boxShadowSecondary: const Color(0xFF28265A).withValues(alpha: 0.06),
      sale: const Color(0xFFE5484D),
      success: const Color(0xFF2E9E6B),
      warning: const Color(0xFFF2B01E),
      primarySoft: AppColors.primary.withValues(alpha: 0.08),
    );
  }

  static AppColorThemeExt dark() {
    const primary = Color(0xFF8B89F0);
    return AppColorThemeExt(
      pageDefault: const Color(0xFF0F0F14),
      textDefault: const Color(0xFFF2F2F7),
      iconDefault: const Color(0xFFE2E2EA),
      iconSecondary: const Color(0xFF9A9AAA),
      textSubTitle: const Color(0xFF9A9AAA),
      cardDefault: const Color(0xFF1A1A22),
      boxShadowDefault: SdColorsV5.black.withValues(alpha: 0.4),
      borderDefault: const Color(0xFF2A2A35),
      indicatorActive: primary,
      indicatorBg: const Color(0xFF9A9AAA).withValues(alpha: 0.3),
      primary: primary,
      surfaceDefault: const Color(0xFF1A1A22),
      primaryShadowDefault: primary.withValues(alpha: 0.2),
      cardOnSurface: const Color(0xFF22222C),
      boxShadowSecondary: SdColorsV5.black.withValues(alpha: 0.3),
      sale: const Color(0xFFFF6B6F),
      success: const Color(0xFF4CC38A),
      warning: const Color(0xFFF5C451),
      primarySoft: primary.withValues(alpha: 0.12),
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
