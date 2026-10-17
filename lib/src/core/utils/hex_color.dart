import 'package:flutter/painting.dart';

/// `#RRGGBB` from the catalogue to a [Color]. Lives in presentation-facing
/// core so the domain can keep colours as plain text.
Color hexColor(String hex) {
  final String clean = hex.replaceFirst('#', '');
  return Color(int.parse(clean.length == 6 ? 'FF$clean' : clean, radix: 16));
}
