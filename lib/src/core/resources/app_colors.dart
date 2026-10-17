import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

/// Tuku Shop's palette, handed to the design system as [SdThemeV5].
///
/// Ink on warm paper in light mode, warm paper on ink in dark: the primary
/// action is always the highest-contrast colour on screen, and the one
/// saturated hue — [_accent] — is kept for sales so a discount is never
/// confused with a button.
abstract final class AppColors {
  static const Color _ink = Color(0xFF151515);
  static const Color _paper = Color(0xFFF4F1EC);
  static const Color _accent = Color(0xFFD9483B);
  static const Color _accentDark = Color(0xFFFF6B5B);

  static const SdThemeV5 light = SdThemeV5(
    background: Color(0xFFF7F5F2),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFFFFF),
    surfaceSunken: Color(0xFFEFECE7),
    photoBackdrop: Color(0xFFF1EFEC),
    textPrimary: _ink,
    textSecondary: Color(0xFF5F5A55),
    textTertiary: Color(0xFF8F8983),
    textPlaceholder: Color(0xFFB4AEA7),
    border: Color(0xFFE2DDD7),
    divider: Color(0xFFECE8E3),
    accent: _accent,
    onAccent: Color(0xFFFFFFFF),
    success: Color(0xFF1E8E5A),
    warning: Color(0xFFC77700),
    danger: Color(0xFFC9372C),
    info: Color(0xFF2F6FDB),
    rating: Color(0xFFF2A100),
    barrier: Color(0x8C000000),
    shadow: Color(0x171B1410),
    skeletonBase: Color(0xFFEAE6E1),
    skeletonHighlight: Color(0xFFF6F4F1),
  );

  static const SdThemeV5 dark = SdThemeV5(
    background: Color(0xFF0F0F10),
    surface: Color(0xFF19191B),
    surfaceElevated: Color(0xFF222225),
    surfaceSunken: Color(0xFF242427),
    // Studio shots are cut on white; a near-white tile keeps them from
    // reading as glowing rectangles on the dark page.
    photoBackdrop: Color(0xFFE8E6E3),
    textPrimary: _paper,
    textSecondary: Color(0xFFB3ADA6),
    textTertiary: Color(0xFF8A847E),
    textPlaceholder: Color(0xFF615C57),
    border: Color(0xFF34322F),
    divider: Color(0xFF272523),
    accent: _accentDark,
    onAccent: Color(0xFF1A0B09),
    success: Color(0xFF3DBE80),
    warning: Color(0xFFF0A23B),
    danger: Color(0xFFFF6B5B),
    info: Color(0xFF6E9BFF),
    rating: Color(0xFFFFC042),
    barrier: Color(0xB3000000),
    shadow: Color(0x66000000),
    skeletonBase: Color(0xFF232325),
    skeletonHighlight: Color(0xFF303033),
  );

  static ColorScheme scheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final SdThemeV5 palette = isDark ? dark : light;

    return ColorScheme(
      brightness: brightness,
      primary: palette.textPrimary,
      onPrimary: palette.background,
      secondary: palette.accent,
      onSecondary: palette.onAccent,
      error: palette.danger,
      onError: isDark ? _ink : const Color(0xFFFFFFFF),
      surface: palette.surface,
      onSurface: palette.textPrimary,
      surfaceContainerHighest: palette.surfaceSunken,
      outline: palette.border,
      outlineVariant: palette.divider,
      shadow: palette.shadow,
    );
  }
}
