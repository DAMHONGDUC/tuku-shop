import 'package:flutter/material.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The filter icon for app bars, next to the cart; [activeCount] badges it
/// and tints it with the brand color while filters are on.
class FilterActionButton extends StatelessWidget {
  const FilterActionButton({
    super.key,
    required this.onTap,
    this.activeCount = 0,
  });

  final VoidCallback onTap;
  final int activeCount;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: Icons.tune_rounded,
      label: context.loc.filter_title,
      iconColor: activeCount > 0 ? context.colorTheme.primary : null,
      badgeCount: activeCount,
      onTap: onTap,
    );
  }
}
