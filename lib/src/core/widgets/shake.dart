import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:system_design/index.dart';

/// Shakes its child sideways each time [trigger] changes — a nudge at the
/// control the user skipped, such as the size picker.
class Shake extends StatefulWidget {
  const Shake({required this.trigger, required this.child, super.key});

  final int trigger;
  final Widget child;

  @override
  State<Shake> createState() => _ShakeState();
}

class _ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SdMotionV5.slow,
  );

  @override
  void didUpdateWidget(Shake oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.trigger != widget.trigger &&
        !MediaQuery.disableAnimationsOf(context)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    child: widget.child,
    builder: (BuildContext context, Widget? child) => Transform.translate(
      offset: Offset(
        math.sin(_controller.value * math.pi * 6) *
            (1 - _controller.value) *
            SdSpacingConstant.w8,
        0,
      ),
      child: child,
    ),
  );
}
