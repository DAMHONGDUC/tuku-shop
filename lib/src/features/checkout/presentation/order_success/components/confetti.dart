import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

/// One burst of confetti from the top centre that falls and fades. Plays
/// once; nothing at all under reduced motion.
class Confetti extends StatefulWidget {
  const Confetti({super.key});

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  );
  final List<_Piece> _pieces = <_Piece>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_pieces.isNotEmpty || MediaQuery.disableAnimationsOf(context)) return;

    final math.Random random = math.Random(7);
    final List<Color> colors = <Color>[
      context.sdTheme5.accent,
      context.sdTheme5.rating,
      context.sdTheme5.success,
      context.sdTheme5.info,
      context.sdTheme5.textPrimary,
    ];

    for (int i = 0; i < 70; i++) {
      final double angle = -math.pi / 2 + (random.nextDouble() - 0.5) * math.pi * 0.9;
      final double speed = 0.5 + random.nextDouble() * 0.7;
      _pieces.add(
        _Piece(
          vx: math.cos(angle) * speed,
          vy: math.sin(angle) * speed,
          spin: (random.nextDouble() - 0.5) * 12,
          color: colors[i % colors.length],
          size: 5 + random.nextDouble() * 6,
        ),
      );
    }

    Future<void>.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (BuildContext context, Widget? _) => CustomPaint(
      painter: _ConfettiPainter(pieces: _pieces, t: _controller.value),
    ),
  );
}

class _Piece {
  const _Piece({
    required this.vx,
    required this.vy,
    required this.spin,
    required this.color,
    required this.size,
  });

  final double vx;
  final double vy;
  final double spin;
  final Color color;
  final double size;
}

class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter({required this.pieces, required this.t});

  final List<_Piece> pieces;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    if (t == 0 || t == 1) return;

    final Offset origin = Offset(size.width / 2, size.height * 0.3);
    final double scale = size.width * 0.9;
    final Paint paint = Paint();

    for (final _Piece p in pieces) {
      final double x = origin.dx + p.vx * scale * t;
      final double y = origin.dy + p.vy * scale * t + 1.1 * size.height * t * t;

      paint.color = p.color.withValues(alpha: (1 - t).clamp(0, 1));
      canvas
        ..save()
        ..translate(x, y)
        ..rotate(p.spin * t)
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.5),
            const Radius.circular(1.5),
          ),
          paint,
        )
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.t != t;
}
