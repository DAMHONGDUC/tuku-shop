import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A product photo that arcs from where it was added into the cart button
/// on the same screen, shrinking as it goes; the button bumps when it
/// lands. Drawn on the root overlay, so it outlives a sheet closing under
/// it. Skipped with reduced motion or when no cart button is on screen.
class FlyToCart {
  const FlyToCart._();

  static const _duration = Duration(milliseconds: 650);

  /// How far above the higher end the arc peaks.
  static const _lift = 96.0;

  /// The photo's size as it reaches the button.
  static const _endSize = SdSpacingV5.s20;

  static void launch(
    BuildContext context, {
    required Rect from,
    required String imagePath,
  }) {
    if (MediaQuery.disableAnimationsOf(context)) return;
    final landing = CartActionButton.landingFor(context);
    if (landing == null) return;

    final overlay = Overlay.of(context, rootOverlay: true);
    final controller = AnimationController(vsync: overlay, duration: _duration);
    final path = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    );
    final shrink = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    final start = from.center;
    final end = landing.rect.center;
    final peak = Offset(
      (start.dx + end.dx) / 2,
      (start.dy < end.dy ? start.dy : end.dy) - _lift,
    );

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final t = path.value;
          final u = 1 - t;
          // Quadratic Bézier through [peak].
          final center = start * (u * u) + peak * (2 * u * t) + end * (t * t);
          final size = Size.lerp(
            from.size,
            const Size.square(_endSize),
            shrink.value,
          )!;
          // Fades over the last fifth, into the button.
          final opacity = ((1 - controller.value) / 0.2).clamp(0.0, 1.0);

          return Positioned.fromRect(
            rect: Rect.fromCenter(
              center: center,
              width: size.width,
              height: size.height,
            ),
            child: IgnorePointer(
              child: Opacity(
                opacity: opacity,
                child: CatalogImage(
                  path: imagePath,
                  borderRadius:
                      size.shortestSide / 2 * shrink.value +
                      UIConstants.imageRadius * (1 - shrink.value),
                ),
              ),
            ),
          );
        },
      ),
    );

    overlay.insert(entry);
    controller.forward().whenComplete(() {
      entry.remove();
      entry.dispose();
      controller.dispose();
      landing.bump();
    });
  }
}
