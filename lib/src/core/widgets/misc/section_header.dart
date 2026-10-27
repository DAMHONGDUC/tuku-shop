import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A serif section title with an optional "See all" link, and an optional
/// [trailing] (a countdown) right after the title.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final bool hasBottomSpacing;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
    this.hasBottomSpacing = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final showAction = onActionTap != null && (actionText ?? '').isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: hasBottomSpacing ? SdSpacingV5.s12 : 0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SdTextStyleV5.heading20()
                        .wColor(colors.textDefault)
                        .wDisplay(),
                  ),
                ),
                if (trailing != null) ...[
                  SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                  trailing!,
                ],
              ],
            ),
          ),
          if (showAction)
            Semantics(
              button: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onActionTap,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: UIConstants.minTapTarget,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        actionText!,
                        style: SdTextStyleV5.body12()
                            .wSemiBold()
                            .wColor(colors.textSubTitle)
                            .wEyebrow(),
                      ),
                      SdIconV5(
                        iconData: Icons.chevron_right_rounded,
                        iconSize: SdSpacingV5.s16,
                        color: colors.textSubTitle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
