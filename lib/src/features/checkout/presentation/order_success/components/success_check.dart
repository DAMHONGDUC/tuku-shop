import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

/// A filled disc that pops in, then a check mark drawn stroke by stroke.
class SuccessCheck extends StatefulWidget {
  const SuccessCheck({super.key});

  @override
  State<SuccessCheck> createState() => _SuccessCheckState();
}

class _SuccessCheckState extends State<SuccessCheck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else if (!_controller.isAnimating && _controller.value == 0) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = SdSpacingConstant.r88 * 1.3;

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? _) {
        final double disc = Curves.easeOutBack.transform(
          (_controller.value / 0.5).clamp(0, 1),
        );
        final double tick = Curves.easeOutCubic.transform(
          ((_controller.value - 0.4) / 0.6).clamp(0, 1),
        );

        return SizedBox.square(
          dimension: size,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Transform.scale(
                scale: 0.6 + disc * 0.6,
                child: Opacity(
                  opacity: (disc * 0.15).clamp(0, 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.sdTheme5.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: disc,
                child: Container(
                  width: size * 0.72,
                  height: size * 0.72,
                  decoration: BoxDecoration(
                    color: context.sdTheme5.success,
                    shape: BoxShape.circle,
                  ),
                  child: CustomPaint(
                    painter: _TickPainter(progress: tick, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TickPainter extends CustomPainter {
  const _TickPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(size.width * 0.28, size.height * 0.52)
      ..lineTo(size.width * 0.44, size.height * 0.67)
      ..lineTo(size.width * 0.73, size.height * 0.36);
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.085
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final PathMetric metric in path.computeMetrics()) {
      canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);
    }
  }

  @override
  bool shouldRepaint(_TickPainter old) => old.progress != progress;
}
