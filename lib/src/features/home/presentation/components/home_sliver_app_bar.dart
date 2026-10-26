import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The search pill and the cart on one row; snaps back into view on
/// scroll up. The pill is the same [AppSearchBar] the Search screen edits.
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
      title: AppSearchBar(
        hintText: context.loc.home_search_hint,
        onTap: () => context.push(HomeRoutes.searchLocation()),
        onFilterTap: () =>
            context.push(HomeRoutes.searchLocation(filters: true)),
      ),
    );
  }
}
