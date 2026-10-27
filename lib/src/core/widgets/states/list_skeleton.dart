import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// What sits at the start of each placeholder row.
enum ListSkeletonLeading {
  none,

  /// A round avatar (chats, notifications, categories).
  avatar,

  /// A product-photo rectangle (orders, cart lines).
  thumbnail,
}

/// The loading state of a vertical list: [rows] placeholder rows (5 by
/// default), everything aligned to the start, lines of varied width so it
/// reads like real data. Not scrollable; place it inside the list's own
/// scroll view or padding.
class ListSkeleton extends StatelessWidget {
  const ListSkeleton({
    super.key,
    this.rows = 5,
    this.leading = ListSkeletonLeading.none,
    this.lines = 2,
    this.card = false,
    this.divided = false,
  });

  final int rows;
  final ListSkeletonLeading leading;

  /// Text lines per row, 1 to 3: a title, then shorter body lines.
  final int lines;

  /// Wraps each row in a card, for lists of cards (orders, notifications).
  final bool card;

  /// A hairline between rows, for flat lists (inbox, categories).
  final bool divided;

  /// Width of each line as a share of the row, varied per row.
  static const _widths = [
    [0.55, 0.9, 0.4],
    [0.7, 0.75, 0.5],
    [0.45, 0.85, 0.3],
    [0.65, 0.7, 0.45],
    [0.5, 0.95, 0.35],
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    Widget row(int i) {
      final widths = _widths[i % _widths.length];
      final content = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          switch (leading) {
            ListSkeletonLeading.none => const SizedBox.shrink(),
            ListSkeletonLeading.avatar => const Padding(
              padding: EdgeInsets.only(right: SdSpacingV5.s12),
              child: SkeletonBox(width: 44, height: 44, radius: 22),
            ),
            ListSkeletonLeading.thumbnail => const Padding(
              padding: EdgeInsets.only(right: SdSpacingV5.s12),
              child: SkeletonBox(
                width: 64,
                height: 80,
                radius: UIConstants.imageRadius,
              ),
            ),
          },
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var l = 0; l < lines.clamp(1, 3); l++) ...[
                  if (l > 0) SdVerticalSpacingV5(value: SdSpacingV5.s8),
                  FractionallySizedBox(
                    alignment: AlignmentDirectional.centerStart,
                    widthFactor: widths[l],
                    child: SkeletonBox(
                      height: l == 0 ? SdSpacingV5.s14 : SdSpacingV5.s12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );

      if (card) {
        return Container(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          decoration: BoxDecoration(
            color: colors.cardDefault,
            borderRadius: BorderRadius.circular(UIConstants.cardRadius),
          ),
          child: content,
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s12),
        child: content,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < rows; i++) ...[
          if (i > 0 && card) SdVerticalSpacingV5(value: SdSpacingV5.s12),
          if (i > 0 && divided) Divider(height: 1, color: colors.borderDefault),
          row(i),
        ],
      ],
    );
  }
}
