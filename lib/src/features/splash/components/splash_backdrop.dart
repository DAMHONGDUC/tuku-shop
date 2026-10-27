import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The app icon's purple gradient, with two soft glows drifting across it
/// while [loop] runs.
class SplashBackdrop extends StatelessWidget {
  const SplashBackdrop({super.key, required this.loop, required this.child});

  final Animation<double> loop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.brandLight, AppColors.brandDeep],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(child: CustomPaint(painter: _GlowPainter(loop))),
          child,
        ],
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  _GlowPainter(this.loop) : super(repaint: loop);

  final Animation<double> loop;

  @override
  void paint(Canvas canvas, Size size) {
    final a = loop.value * 2 * pi;
    final w = size.width;
    // One glow above the logo's left, one below its right, circling slowly.
    _glow(
      canvas,
      Offset(w * (0.1 + 0.06 * sin(a)), size.height * (0.18 + 0.03 * cos(a))),
      w * 0.75,
      0.22,
    );
    _glow(
      canvas,
      Offset(w * (0.95 - 0.06 * cos(a)), size.height * (0.82 + 0.03 * sin(a))),
      w * 0.7,
      0.16,
    );
  }

  void _glow(Canvas canvas, Offset center, double radius, double alpha) {
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.white.withValues(alpha: alpha),
            AppColors.white.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
  }

  @override
  bool shouldRepaint(_GlowPainter old) => old.loop != loop;
}
