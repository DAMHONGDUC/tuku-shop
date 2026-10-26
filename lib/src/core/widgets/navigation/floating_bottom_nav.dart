import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// One tab of [FloatingBottomNav].
class FloatingNavDestination {
  const FloatingNavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.badgeCount = 0,
  });

  final IconData icon;
  final IconData selectedIcon;

  /// Painted under the glyph and read by screen readers.
  final String label;
  final int badgeCount;
}

/// A floating, labelled tab bar over its body: a V5 rebuild of the design
/// kit's V3 bottom navigation, from V5 tokens only.
///
/// The body scrolls behind the bar, which stays fixed in place. A
/// horizontal swipe on the body moves to the adjacent tab.
class FloatingBottomNav extends StatefulWidget {
  const FloatingBottomNav({
    super.key,
    required this.body,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
  });

  final Widget body;
  final List<FloatingNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const double barHeight = SdSpacingV5.s64;
  static const double sideMargin = SdSpacingV5.s16;
  static const double _minOffset = SdSpacingV5.s16;
  static const double _maxOffset = SdSpacingV5.s20;
  static const double _swipeDistance = SdSpacingV5.s48;

  /// How far the bar sits above the bottom edge.
  static double barOffset(BuildContext context) {
    final safeBottom = MediaQuery.viewPaddingOf(context).bottom;
    return math.min(math.max(safeBottom, _minOffset), _maxOffset);
  }

  /// Bottom padding a tab screen needs so its last row clears the bar.
  static double contentInset(BuildContext context) =>
      barOffset(context) + barHeight + SdSpacingV5.s16;

  @override
  State<FloatingBottomNav> createState() => _FloatingBottomNavState();
}

class _FloatingBottomNavState extends State<FloatingBottomNav> {
  double _dragDistance = 0;

  void _finishSwipe(DragEndDetails _) {
    final distance = _dragDistance;
    _dragDistance = 0;
    if (distance.abs() < FloatingBottomNav._swipeDistance) return;
    final next = widget.selectedIndex + (distance < 0 ? 1 : -1);
    if (next < 0 || next >= widget.destinations.length) return;
    widget.onSelected(next);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.colorTheme.pageDefault,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        excludeFromSemantics: true,
        onHorizontalDragStart: (_) => _dragDistance = 0,
        onHorizontalDragUpdate: (d) => _dragDistance += d.primaryDelta ?? 0,
        onHorizontalDragCancel: () => _dragDistance = 0,
        onHorizontalDragEnd: _finishSwipe,
        child: widget.body,
      ),
      bottomNavigationBar: FloatingBottomNavBar(
        destinations: widget.destinations,
        selectedIndex: widget.selectedIndex,
        onSelected: widget.onSelected,
      ),
    );
  }
}

/// The bar itself: a frosted stadium with a sliding capsule under the
/// current tab.
class FloatingBottomNavBar extends StatelessWidget {
  const FloatingBottomNavBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<FloatingNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const double _radius = FloatingBottomNav.barHeight / 2;
  static const double _capsuleInset = SdSpacingV5.s4;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final count = destinations.length;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        FloatingBottomNav.sideMargin,
        0,
        FloatingBottomNav.sideMargin,
        FloatingBottomNav.barOffset(context),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          boxShadow: [
            BoxShadow(
              color: colors.boxShadowDefault,
              blurRadius: SdSpacingV5.s24,
              offset: const Offset(0, SdSpacingV5.s8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
              height: FloatingBottomNav.barHeight,
              decoration: BoxDecoration(
                color: colors.surfaceDefault.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(_radius),
                border: Border.all(color: colors.borderDefault),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedAlign(
                    duration: UIConstants.navNormal,
                    curve: Curves.easeInOutCubic,
                    alignment: AlignmentDirectional(
                      count == 1 ? 0 : -1 + 2 * selectedIndex / (count - 1),
                      0,
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 1 / count,
                      heightFactor: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(_capsuleInset),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(
                              _radius - _capsuleInset,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      for (var i = 0; i < count; i++)
                        Expanded(
                          child: _NavCell(
                            destination: destinations[i],
                            selected: i == selectedIndex,
                            onTap: () => onSelected(i),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavCell extends StatelessWidget {
  const _NavCell({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final FloatingNavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final color = selected ? colors.primary : colors.iconSecondary;
    final badge = destination.badgeCount;

    return Semantics(
      button: true,
      selected: selected,
      label: badge > 0 ? '${destination.label}, $badge' : destination.label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedSwitcher(
                  duration: UIConstants.navFast,
                  child: SdIconV5(
                    key: ValueKey(selected),
                    iconData: selected
                        ? destination.selectedIcon
                        : destination.icon,
                    iconSize: SdSpacingV5.s22,
                    color: color,
                  ),
                ),
                if (badge > 0)
                  Positioned(
                    right: -SdSpacingV5.s10,
                    top: -SdSpacingV5.s6,
                    child: SdBadgeV5(
                      count: badge,
                      size: SdSpacingV5.s16,
                      badgeColor: colors.sale,
                    ),
                  ),
              ],
            ),
            SdVerticalSpacingV5(value: SdSpacingV5.s2),
            Text(
              destination.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  (selected
                          ? SdTextStyleV5.body10().wSemiBold()
                          : SdTextStyleV5.body10())
                      .wColor(color),
            ),
          ],
        ),
      ),
    );
  }
}
