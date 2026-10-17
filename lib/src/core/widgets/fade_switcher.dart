import 'package:flutter/widgets.dart';
import 'package:system_design/index.dart';

/// Cross-fades between a screen's loading, error and loaded states, so a
/// skeleton dissolves into content instead of being swapped out.
class FadeSwitcher extends StatelessWidget {
  const FadeSwitcher({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: SdMotionV5.of(context, SdMotionV5.normal),
    switchInCurve: SdMotionV5.standard,
    switchOutCurve: SdMotionV5.exit,
    layoutBuilder: (Widget? current, List<Widget> previous) => Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[...previous, ?current],
    ),
    child: child,
  );
}
