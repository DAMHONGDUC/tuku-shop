import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

final _kIconPadding = SdSpacingV5.s6;
final _kTitleSpacing = SdSpacingV5.s12;

class NotificationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SdAppBarV5(
      centerTitle: true,
      titleText: 'Notifications',
      showBackButton: false,
      titleSpacing: _kTitleSpacing,
      actionPadding: EdgeInsets.only(right: _kTitleSpacing - _kIconPadding),
      actions: [
        SdIconButtonV5(
          padding: EdgeInsets.all(_kIconPadding),
          onPressed: () {},
          icon: SdIconV5(
            iconData: Icons.shopping_cart,
            color: context.colorTheme.primary,
          ),
        ),
        SdHorizontalSpacingV5(xRatio: 0.5),
        SdIconButtonV5(
          padding: EdgeInsets.all(_kIconPadding),
          onPressed: () {},
          icon: SdIconV5(
            iconData: Icons.chat_bubble_outline,
            color: context.colorTheme.primary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
