import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The app icon's bag in white. During [intro] it pops in, its handle
/// draws on from both ends and the "T" drops into place.
class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, required this.intro});

  final Animation<double> intro;

  /// The canvas: the bag plus room for its pop overshoot and shadow.
  static const _size = Size(160, 184);

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: CustomPaint(size: _size, painter: _BagPainter(intro)),
      ),
    );
  }
}

/// Paints in the 1024-unit grid of `assets/images/app_icon.png`.
class _BagPainter extends CustomPainter {
  _BagPainter(this.intro) : super(repaint: intro);

  final Animation<double> intro;

  /// The bag's drawn width; the icon's bag is 480 units wide.
  static const _bagWidth = 112.0;
  static const _unit = _bagWidth / 480;

  /// The bag's centre (handle top to body bottom) in icon units.
  static const _bagCenter = Offset(512, 507);

  static final _body = RRect.fromLTRBR(
    272,
    364,
    752,
    804,
    const Radius.circular(76),
  );
  static const _handleOval = Rect.fromLTRB(401, 233, 623, 495);
  static const _holes = [Offset(400, 404), Offset(624, 404)];
  static const _letterBar = Rect.fromLTRB(426, 492, 598, 537);
  static const _letterStem = Rect.fromLTRB(485, 537, 539, 705);

  @override
  void paint(Canvas canvas, Size size) {
    final t = intro.value;
    final fade = const Interval(0, 0.25).transform(t);
    final pop = const Interval(0, 0.45, curve: Curves.easeOutBack).transform(t);
    final handle = const Interval(
      0.2,
      0.6,
      curve: Curves.easeOutCubic,
    ).transform(t);
    final letter = const Interval(
      0.45,
      0.7,
      curve: Curves.easeOutBack,
    ).transform(t);
    final center = size.center(Offset.zero);

    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..scale(_unit * pop)
      ..translate(-_bagCenter.dx, -_bagCenter.dy);

    canvas.drawRRect(
      _body.shift(const Offset(0, 40)),
      Paint()
        ..color = AppColors.ink.withValues(alpha: 0.22 * fade)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 48),
    );
    _paintHandle(canvas, handle, fade);
    canvas.drawRRect(
      _body,
      Paint()..color = AppColors.white.withValues(alpha: fade),
    );

    final cutout = Paint()..color = AppColors.brand.withValues(alpha: fade);
    for (final hole in _holes) {
      canvas.drawCircle(hole, 20, cutout);
    }

    final letterPaint = Paint()
      ..color = AppColors.brand.withValues(alpha: letter.clamp(0, 1));
    final drop = Offset(0, -60 * (1 - letter));
    canvas
      ..drawRect(_letterBar.shift(drop), letterPaint)
      ..drawRect(_letterStem.shift(drop), letterPaint)
      ..restore();
  }

  /// The arch, drawn from both feet up to meet at the top.
  void _paintHandle(Canvas canvas, double progress, double alpha) {
    if (progress <= 0) return;
    final arch = Path()..addArc(_handleOval, pi, pi);
    final metric = arch.computeMetrics().single;
    final half = metric.length / 2 * progress.clamp(0, 1);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 46
      ..color = AppColors.white.withValues(alpha: alpha);
    canvas
      ..drawPath(metric.extractPath(0, half), paint)
      ..drawPath(
        metric.extractPath(metric.length - half, metric.length),
        paint,
      );
  }

  @override
  bool shouldRepaint(_BagPainter old) => old.intro != intro;
}
