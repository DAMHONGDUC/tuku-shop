import 'package:flutter/material.dart';

/// Text uses the platform's own UI font (San Francisco on iOS, Roboto on
/// Android), the way Shopee does: familiar to everyone, sharp at every
/// size, full Vietnamese support. Titles only tighten the tracking.
extension AppTypographyX on TextStyle {
  /// Titles, section headers and hero prices.
  TextStyle wDisplay() => copyWith(letterSpacing: -0.3);

  /// Small spaced capitals for brand names and eyebrow labels.
  TextStyle wEyebrow() => copyWith(letterSpacing: 1.2);
}
