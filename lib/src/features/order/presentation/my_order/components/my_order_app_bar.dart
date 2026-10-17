import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

final _kIconPadding = SdSpacingV5.s6;
final _kTitleSpacing = SdSpacingV5.s12;
final _kBottomHeight = SdSpacingV5.s40;

class MyOrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyOrderAppBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SdAppBarV5(
      titleText: 'My order',
      showBackButton: false,
      titleSpacing: _kTitleSpacing,
      actionPadding: EdgeInsets.only(right: _kTitleSpacing - _kIconPadding),
      actions: [
        SdIconButtonV5(
          padding: EdgeInsets.all(_kIconPadding),
          onPressed: () {},
          icon: SdIconV5(
            iconData: Icons.search,
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
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_kBottomHeight),
        child: TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: tabController,
          dividerColor: SdColorsV5.transparent,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.symmetric(
            horizontal: SdSpacingV5.s16,
            vertical: SdSpacingV5.s2,
          ),
          labelStyle: SdTextStyleV5.body14()
              .wColor(context.colorTheme.primary)
              .wSemiBold(),
          unselectedLabelStyle: SdTextStyleV5.body14().wColor(
            context.colorTheme.textDefault,
          ),
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(SdSpacingV5.s100),
            borderSide: BorderSide(
              width: SdSpacingV5.s3,
              color: context.colorTheme.primary,
            ),
          ),
          tabs: OrderStatusExt.tabs
              .map((e) => Tab(text: e.label, height: SdSpacingV5.s32))
              .toList(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + _kBottomHeight);
}
