import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The app bar every screen uses: page-colored, flat, a serif title and the
/// cart button last in [actions] unless [showCart] is false.
///
/// [large] is for tab roots: no back button, a left-aligned bigger title.
/// [centerTitle] false puts the title right after the back button (a chat
/// header).
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions = const [],
    this.showCart = true,
    this.large = false,
    this.centerTitle,
    this.bottom,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget> actions;
  final bool showCart;
  final bool large;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final style = large
        ? SdTextStyleV5.heading24().wColor(colors.textDefault).wDisplay()
        : SdTextStyleV5.heading18().wColor(colors.textDefault).wDisplay();
    final center = centerTitle ?? !large;

    return SdAppBarV5(
      titleWidget:
          titleWidget ??
          (title == null
              ? null
              : Text(
                  title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style,
                )),
      centerTitle: center,
      showBackButton: !large,
      backgroundColor: colors.pageDefault,
      backButtonIconColor: colors.iconDefault,
      noElevation: true,
      titleSpacing: large
          ? SdSpacingV5.s16
          : center
          ? SdSpacingV5.s12
          : 0,
      actionPadding: EdgeInsets.only(right: SdSpacingV5.s8),
      actions: [...actions, if (showCart) const CartActionButton()],
      bottom: bottom,
    );
  }
}
