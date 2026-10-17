import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Search pill and notification bell; snaps back into view on scroll up.
class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key, this.unreadNotifications = 0});

  final int unreadNotifications;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: colors.pageDefault,
      surfaceTintColor: SdColorsV5.transparent,
      elevation: 0,
      toolbarHeight: SdSpacingV5.s64,
      titleSpacing: SdSpacingV5.s16,
      title: Row(
        children: [
          Expanded(
            child: Semantics(
              button: true,
              child: GestureDetector(
                onTap: () => context.push(HomeRoutes.search.fullPath),
                child: Container(
                  height: SdSpacingV5.s44,
                  padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s12),
                  decoration: BoxDecoration(
                    color: colors.cardDefault,
                    borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                    border: Border.all(color: colors.borderDefault),
                  ),
                  child: Row(
                    children: [
                      SdIconV5(
                        iconData: Icons.search,
                        iconSize: SdSpacingV5.s20,
                        color: colors.iconSecondary,
                      ),
                      SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                      Text(
                        context.loc.home_search_hint,
                        style: SdTextStyleV5.body14().wColor(
                          colors.textSubTitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SdHorizontalSpacingV5(value: SdSpacingV5.s12),
          Semantics(
            button: true,
            label: context.loc.notifications_title,
            child: GestureDetector(
              onTap: () =>
                  context.push(NotificationsRoutes.notifications.fullPath),
              child: Container(
                width: SdSpacingV5.s44,
                height: SdSpacingV5.s44,
                decoration: BoxDecoration(
                  color: colors.cardDefault,
                  borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                  border: Border.all(color: colors.borderDefault),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    SdIconV5(
                      iconData: Icons.notifications_none_rounded,
                      iconSize: SdSpacingV5.s22,
                      color: colors.iconDefault,
                    ),
                    if (unreadNotifications > 0)
                      Positioned(
                        right: -SdSpacingV5.s4,
                        top: -SdSpacingV5.s4,
                        child: SdBadgeV5(
                          count: unreadNotifications,
                          size: SdSpacingV5.s16,
                          badgeColor: colors.sale,
                        ),
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
