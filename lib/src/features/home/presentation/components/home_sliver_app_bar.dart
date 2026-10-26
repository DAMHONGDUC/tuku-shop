import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The search pill and the cart on one row; snaps back into view on
/// scroll up.
class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: colors.pageDefault,
      surfaceTintColor: SdColorsV5.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: SdSpacingV5.s64,
      titleSpacing: SdSpacingV5.s16,
      actionsPadding: EdgeInsets.only(right: SdSpacingV5.s8),
      actions: const [CartActionButton()],
      title: Semantics(
        button: true,
        label: context.loc.home_search_hint,
        excludeSemantics: true,
        child: GestureDetector(
          onTap: () => context.push(HomeRoutes.search.fullPath),
          child: Container(
            height: SdSpacingV5.s44,
            padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
            decoration: BoxDecoration(
              color: colors.cardDefault,
              borderRadius: BorderRadius.circular(SdSpacingV5.s100),
            ),
            child: Row(
              children: [
                SdIconV5(
                  iconData: Icons.search,
                  iconSize: SdSpacingV5.s20,
                  color: colors.iconSecondary,
                ),
                SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                Expanded(
                  child: Text(
                    context.loc.home_search_hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                  ),
                ),
                SdIconV5(
                  iconData: Icons.tune_rounded,
                  iconSize: SdSpacingV5.s20,
                  color: colors.iconSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
