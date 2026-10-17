import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

final _kIconPadding = SdSpacingV5.s6;
final _kTitleSpacing = SdSpacingV5.s12;

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SdAppBarV5(
      centerTitle: true,
      titleText: 'Account',
      showBackButton: false,
      titleSpacing: _kTitleSpacing,
      actionPadding: EdgeInsets.only(right: _kTitleSpacing - _kIconPadding),
      actions: [
        SdIconButtonV5(
          padding: EdgeInsets.all(_kIconPadding),
          onPressed: () {},
          icon: SdIconV5(
            iconData: Icons.more_vert,
            color: context.colorTheme.primary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
