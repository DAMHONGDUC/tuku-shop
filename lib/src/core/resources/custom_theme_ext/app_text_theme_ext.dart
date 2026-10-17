import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:system_design/index.dart';

class AppTextThemeExt extends ThemeExtension<AppTextThemeExt> {
  // Body styles
  final TextStyle body6;
  final TextStyle body8;
  final TextStyle body10;
  final TextStyle body12;
  final TextStyle body14;
  final TextStyle body16;
  final TextStyle body18;
  final TextStyle body20;
  final TextStyle body24;
  final TextStyle body32;
  final TextStyle body40;
  final TextStyle body48;
  final TextStyle body56;
  final TextStyle body64;
  final TextStyle body72;

  // Heading styles
  final TextStyle heading6;
  final TextStyle heading8;
  final TextStyle heading10;
  final TextStyle heading12;
  final TextStyle heading13;
  final TextStyle heading14;
  final TextStyle heading16;
  final TextStyle heading18;
  final TextStyle heading20;
  final TextStyle heading24;
  final TextStyle heading28;
  final TextStyle heading32;
  final TextStyle heading40;
  final TextStyle heading48;
  final TextStyle heading56;
  final TextStyle heading64;
  final TextStyle heading72;

  AppTextThemeExt({
    // Body styles
    required this.body6,
    required this.body8,
    required this.body10,
    required this.body12,
    required this.body14,
    required this.body16,
    required this.body18,
    required this.body20,
    required this.body24,
    required this.body32,
    required this.body40,
    required this.body48,
    required this.body56,
    required this.body64,
    required this.body72,
    // Heading styles
    required this.heading6,
    required this.heading8,
    required this.heading10,
    required this.heading12,
    required this.heading13,
    required this.heading14,
    required this.heading16,
    required this.heading18,
    required this.heading20,
    required this.heading24,
    required this.heading28,
    required this.heading32,
    required this.heading40,
    required this.heading48,
    required this.heading56,
    required this.heading64,
    required this.heading72,
  });

  static TextStyle _applyFont(TextStyle style) {
    return GoogleFonts.lato(
      fontSize: style.fontSize,
      fontWeight: style.fontWeight,
      color: style.color,
    );
  }

  // Light theme
  static AppTextThemeExt light() {
    final lightTextColor = AppColors.textDefaultLight;

    return AppTextThemeExt(
      // Body styles
      body6: _applyFont(SdTextStyleV5.body6().wColor(lightTextColor)),
      body8: _applyFont(SdTextStyleV5.body8().wColor(lightTextColor)),
      body10: _applyFont(SdTextStyleV5.body10().wColor(lightTextColor)),
      body12: _applyFont(SdTextStyleV5.body12().wColor(lightTextColor)),
      body14: _applyFont(SdTextStyleV5.body14().wColor(lightTextColor)),
      body16: _applyFont(SdTextStyleV5.body16().wColor(lightTextColor)),
      body18: _applyFont(SdTextStyleV5.body18().wColor(lightTextColor)),
      body20: _applyFont(SdTextStyleV5.body20().wColor(lightTextColor)),
      body24: _applyFont(SdTextStyleV5.body24().wColor(lightTextColor)),
      body32: _applyFont(SdTextStyleV5.body32().wColor(lightTextColor)),
      body40: _applyFont(SdTextStyleV5.body40().wColor(lightTextColor)),
      body48: _applyFont(SdTextStyleV5.body48().wColor(lightTextColor)),
      body56: _applyFont(SdTextStyleV5.body56().wColor(lightTextColor)),
      body64: _applyFont(SdTextStyleV5.body64().wColor(lightTextColor)),
      body72: _applyFont(SdTextStyleV5.body72().wColor(lightTextColor)),
      // Heading styles
      heading6: _applyFont(SdTextStyleV5.heading6().wColor(lightTextColor)),
      heading8: _applyFont(SdTextStyleV5.heading8().wColor(lightTextColor)),
      heading10: _applyFont(SdTextStyleV5.heading10().wColor(lightTextColor)),
      heading12: _applyFont(SdTextStyleV5.heading12().wColor(lightTextColor)),
      heading13: _applyFont(SdTextStyleV5.heading13().wColor(lightTextColor)),
      heading14: _applyFont(SdTextStyleV5.heading14().wColor(lightTextColor)),
      heading16: _applyFont(SdTextStyleV5.heading16().wColor(lightTextColor)),
      heading18: _applyFont(SdTextStyleV5.heading18().wColor(lightTextColor)),
      heading20: _applyFont(SdTextStyleV5.heading20().wColor(lightTextColor)),
      heading24: _applyFont(SdTextStyleV5.heading24().wColor(lightTextColor)),
      heading28: _applyFont(SdTextStyleV5.heading28().wColor(lightTextColor)),
      heading32: _applyFont(SdTextStyleV5.heading32().wColor(lightTextColor)),
      heading40: _applyFont(SdTextStyleV5.heading40().wColor(lightTextColor)),
      heading48: _applyFont(SdTextStyleV5.heading48().wColor(lightTextColor)),
      heading56: _applyFont(SdTextStyleV5.heading56().wColor(lightTextColor)),
      heading64: _applyFont(SdTextStyleV5.heading64().wColor(lightTextColor)),
      heading72: _applyFont(SdTextStyleV5.heading72().wColor(lightTextColor)),
    );
  }

  // Dark theme
  // TODO: create text theme for dark theme
  // for now it's have same value with light
  static AppTextThemeExt dark() {
    return AppTextThemeExt.light();
  }

  @override
  ThemeExtension<AppTextThemeExt> copyWith({
    // Body styles
    TextStyle? body6,
    TextStyle? body8,
    TextStyle? body9,
    TextStyle? body10,
    TextStyle? body12,
    TextStyle? body14,
    TextStyle? body16,
    TextStyle? body18,
    TextStyle? body20,
    TextStyle? body24,
    TextStyle? body32,
    TextStyle? body40,
    TextStyle? body48,
    TextStyle? body56,
    TextStyle? body64,
    TextStyle? body72,
    // Heading styles
    TextStyle? heading6,
    TextStyle? heading8,
    TextStyle? heading9,
    TextStyle? heading10,
    TextStyle? heading12,
    TextStyle? heading13,
    TextStyle? heading14,
    TextStyle? heading16,
    TextStyle? heading18,
    TextStyle? heading20,
    TextStyle? heading24,
    TextStyle? heading28,
    TextStyle? heading32,
    TextStyle? heading40,
    TextStyle? heading48,
    TextStyle? heading56,
    TextStyle? heading64,
    TextStyle? heading72,
  }) {
    return AppTextThemeExt(
      // Body styles
      body6: body6 ?? this.body6,
      body8: body8 ?? this.body8,
      body10: body10 ?? this.body10,
      body12: body12 ?? this.body12,
      body14: body14 ?? this.body14,
      body16: body16 ?? this.body16,
      body18: body18 ?? this.body18,
      body20: body20 ?? this.body20,
      body24: body24 ?? this.body24,
      body32: body32 ?? this.body32,
      body40: body40 ?? this.body40,
      body48: body48 ?? this.body48,
      body56: body56 ?? this.body56,
      body64: body64 ?? this.body64,
      body72: body72 ?? this.body72,
      // Heading styles
      heading6: heading6 ?? this.heading6,
      heading8: heading8 ?? this.heading8,
      heading10: heading10 ?? this.heading10,
      heading12: heading12 ?? this.heading12,
      heading13: heading13 ?? this.heading13,
      heading14: heading14 ?? this.heading14,
      heading16: heading16 ?? this.heading16,
      heading18: heading18 ?? this.heading18,
      heading20: heading20 ?? this.heading20,
      heading24: heading24 ?? this.heading24,
      heading28: heading28 ?? this.heading28,
      heading32: heading32 ?? this.heading32,
      heading40: heading40 ?? this.heading40,
      heading48: heading48 ?? this.heading48,
      heading56: heading56 ?? this.heading56,
      heading64: heading64 ?? this.heading64,
      heading72: heading72 ?? this.heading72,
    );
  }

  @override
  ThemeExtension<AppTextThemeExt> lerp(
    covariant ThemeExtension<AppTextThemeExt>? other,
    double t,
  ) {
    if (other is! AppTextThemeExt) return this;

    return AppTextThemeExt(
      // Body styles
      body6: TextStyle.lerp(body6, other.body6, t)!,
      body8: TextStyle.lerp(body8, other.body8, t)!,
      body10: TextStyle.lerp(body10, other.body10, t)!,
      body12: TextStyle.lerp(body12, other.body12, t)!,
      body14: TextStyle.lerp(body14, other.body14, t)!,
      body16: TextStyle.lerp(body16, other.body16, t)!,
      body18: TextStyle.lerp(body18, other.body18, t)!,
      body20: TextStyle.lerp(body20, other.body20, t)!,
      body24: TextStyle.lerp(body24, other.body24, t)!,
      body32: TextStyle.lerp(body32, other.body32, t)!,
      body40: TextStyle.lerp(body40, other.body40, t)!,
      body48: TextStyle.lerp(body48, other.body48, t)!,
      body56: TextStyle.lerp(body56, other.body56, t)!,
      body64: TextStyle.lerp(body64, other.body64, t)!,
      body72: TextStyle.lerp(body72, other.body72, t)!,
      // Heading styles
      heading6: TextStyle.lerp(heading6, other.heading6, t)!,
      heading8: TextStyle.lerp(heading8, other.heading8, t)!,
      heading10: TextStyle.lerp(heading10, other.heading10, t)!,
      heading12: TextStyle.lerp(heading12, other.heading12, t)!,
      heading13: TextStyle.lerp(heading13, other.heading13, t)!,
      heading14: TextStyle.lerp(heading14, other.heading14, t)!,
      heading16: TextStyle.lerp(heading16, other.heading16, t)!,
      heading18: TextStyle.lerp(heading18, other.heading18, t)!,
      heading20: TextStyle.lerp(heading20, other.heading20, t)!,
      heading24: TextStyle.lerp(heading24, other.heading24, t)!,
      heading28: TextStyle.lerp(heading28, other.heading28, t)!,
      heading32: TextStyle.lerp(heading32, other.heading32, t)!,
      heading40: TextStyle.lerp(heading40, other.heading40, t)!,
      heading48: TextStyle.lerp(heading48, other.heading48, t)!,
      heading56: TextStyle.lerp(heading56, other.heading56, t)!,
      heading64: TextStyle.lerp(heading64, other.heading64, t)!,
      heading72: TextStyle.lerp(heading72, other.heading72, t)!,
    );
  }
}
