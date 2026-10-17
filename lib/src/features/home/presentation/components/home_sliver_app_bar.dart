import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

final _kAppBarPadding = SdSpacingV5.s12;
final _kAppBarPaddingTop = SdSpacingV5.s4;
final _kAppBarPaddingBottom = SdSpacingV5.s8;
final _kSearchBarHeight = SdSpacingV5.s40;
final _kAppBarHeight =
    _kSearchBarHeight + _kAppBarPaddingBottom + _kAppBarPaddingTop;
final _kIconPadding = SdSpacingV5.s6;

class HomeSliverAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // floating & snap => make app bar "snap" into view
      floating: true,
      snap: true,
      pinned: false,
      elevation: SdSpacingV5.s2,
      shadowColor: context.colorTheme.primaryShadowDefault,
      toolbarHeight: _kAppBarHeight,
      backgroundColor: context.colorTheme.surfaceDefault,
      surfaceTintColor: SdColorsV5.transparent,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.only(
          left: _kAppBarPadding,
          right: _kAppBarPadding - _kIconPadding,
          bottom: _kAppBarPaddingBottom,
          top: _kAppBarPaddingTop,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: CustomSearchBar(height: _kSearchBarHeight)),
            SdHorizontalSpacingV5(),
            Row(
              children: [
                SdIconButtonV5(
                  padding: EdgeInsets.all(_kIconPadding),
                  onPressed: () {
                    GoRouter.of(context).push(HomeRoutes.search.fullPath);
                  },
                  icon: SdIconV5(
                    iconData: Icons.shopping_cart,
                    color: context.colorTheme.primary,
                  ),
                ),
                SdHorizontalSpacingV5(xRatio: 0.5),
                SdIconButtonV5(
                  padding: EdgeInsets.all(_kIconPadding),
                  onPressed: () {
                    GoRouter.of(context).push(HomeRoutes.search.fullPath);
                  },
                  icon: SdIconV5(
                    iconData: Icons.chat_bubble_outline,
                    color: context.colorTheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_kAppBarHeight);
}
