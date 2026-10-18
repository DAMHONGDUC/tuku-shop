import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart' hide SdContextV2X;

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.height = 40.0,
    this.bgColor,
    this.hasBorder = true,
    this.searchIconSize = SdSpacingV5.s24,
  });
  final double height;
  final Color? bgColor;
  final bool hasBorder;
  final double searchIconSize;

  void _navigateToSearch(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToSearch(context),
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(
          horizontal: SdSpacingV5.s8,
          vertical: SdSpacingV5.s6,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? context.colorTheme.cardDefault,
          borderRadius: BorderRadius.circular(SdSpacingV5.s8),
          border: hasBorder
              ? Border.all(
                  color: context.colorTheme.borderDefault,
                  width: SdSpacingV5.s1,
                )
              : null,
        ),
        child: Row(
          children: [
            SdIconV5(
              iconData: Icons.search,
              color: context.colorTheme.iconDefault,
              iconSize: searchIconSize,
            ),
            SdHorizontalSpacingV5(),
            Text(
              'Search products...',
              style: context.textTheme.body14.wColor(
                context.colorTheme.textSubTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
