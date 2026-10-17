import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// − value + with 36 pt targets; ends disable at [min] and [max].
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 10,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    Widget button(IconData icon, bool enabled, int next, String label) {
      return Semantics(
        button: true,
        enabled: enabled,
        label: label,
        child: InkWell(
          onTap: enabled ? () => onChanged(next) : null,
          borderRadius: BorderRadius.circular(SdSpacingV5.s8),
          child: SizedBox.square(
            dimension: SdSpacingV5.s36,
            child: Icon(
              icon,
              size: SdSpacingV5.s16,
              color: enabled
                  ? colors.textDefault
                  : colors.textSubTitle.withValues(alpha: 0.4),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.borderDefault),
        borderRadius: BorderRadius.circular(SdSpacingV5.s10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          button(Icons.remove, value > min, value - 1, '−'),
          SizedBox(
            width: SdSpacingV5.s28,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: SdTextStyleV5.body14().wSemiBold().copyWith(
                color: colors.textDefault,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
          button(Icons.add, value < max, value + 1, '+'),
        ],
      ),
    );
  }
}
