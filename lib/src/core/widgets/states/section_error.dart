import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A failed section: what went wrong and a Retry, without blocking the rest
/// of the screen.
class SectionError extends StatelessWidget {
  const SectionError({super.key, required this.onRetry, this.message});

  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SdSpacingV5.s16),
      decoration: BoxDecoration(
        color: colors.cardDefault,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      ),
      child: Row(
        children: [
          SdIconV5(iconData: Icons.wifi_off_rounded, color: colors.sale),
          SdHorizontalSpacingV5(),
          Expanded(
            child: Text(
              message ?? context.loc.common_load_failed,
              style: SdTextStyleV5.body14().wColor(colors.textDefault),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(
              context.loc.common_retry,
              style: SdTextStyleV5.body14().wSemiBold().wColor(colors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
