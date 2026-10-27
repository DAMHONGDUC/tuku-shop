import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Three pulsing dots while the other side writes an answer.
class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});

  @override
  State<TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble>
    with SingleTickerProviderStateMixin {
  late final _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Padding(
      padding: EdgeInsets.only(top: SdSpacingV5.s12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SdSpacingV5.s16,
            vertical: SdSpacingV5.s14,
          ),
          decoration: BoxDecoration(
            color: colors.cardDefault,
            borderRadius: BorderRadius.circular(SdSpacingV5.s16),
          ),
          child: AnimatedBuilder(
            animation: _pulse,
            builder: (context, _) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) SdHorizontalSpacingV5(value: SdSpacingV5.s4),
                  Opacity(
                    // Each dot peaks a third of a cycle after the last.
                    opacity:
                        0.3 +
                        0.7 * (1 - ((_pulse.value * 3 - i) % 3).clamp(0, 1)),
                    child: Container(
                      width: SdSpacingV5.s6,
                      height: SdSpacingV5.s6,
                      decoration: BoxDecoration(
                        color: colors.textSubTitle,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
