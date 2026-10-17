import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/cart_controller.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Back, share and bag float over the photo; once the photo scrolls away a
/// surface bar with the product's name fades in behind them.
class DetailTopBar extends StatelessWidget {
  const DetailTopBar({
    required this.scroll,
    required this.fadeAfter,
    required this.title,
    required this.productId,
    super.key,
  });

  final ScrollController scroll;
  final double fadeAfter;
  final String title;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    final int bagCount = context.select<CartController, int>(
      (CartController c) => c.state.itemCount,
    );

    return AnimatedBuilder(
      animation: scroll,
      builder: (BuildContext context, Widget? _) {
        final double offset = scroll.hasClients ? scroll.offset : 0;
        final double t = ((offset - fadeAfter) / SdSpacingConstant.h56).clamp(
          0,
          1,
        );

        return Container(
          padding: EdgeInsets.fromLTRB(
            SdSpacingConstant.w12,
            SdContentPaddingV5.statusBarInset(context) + SdSpacingConstant.h4,
            SdSpacingConstant.w12,
            SdSpacingConstant.h8,
          ),
          decoration: BoxDecoration(
            color: context.sdTheme5.surface.withValues(alpha: t),
            border: Border(
              bottom: BorderSide(
                color: context.sdTheme5.divider.withValues(alpha: t),
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              SdIconButtonV5(
                icon: Symbols.arrow_back_ios_new_rounded,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                variant: t < 1
                    ? SdIconButtonVariantV5.floating
                    : SdIconButtonVariantV5.plain,
                size: SdSpacingConstant.r40,
                onPressed: () => context.pop(),
              ),
              Expanded(
                child: Opacity(
                  opacity: t,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme5.titleSmall,
                  ),
                ),
              ),
              SdIconButtonV5(
                icon: Symbols.ios_share_rounded,
                tooltip: context.loc.action_share,
                variant: t < 1
                    ? SdIconButtonVariantV5.floating
                    : SdIconButtonVariantV5.plain,
                size: SdSpacingConstant.r40,
                onPressed: productId == null
                    ? null
                    : () => SdSnackBarUtilsV5.info(
                        context,
                        context.loc.detail_link_copied,
                      ),
              ),
              SizedBox(width: SdSpacingConstant.w8),
              SdIconButtonV5(
                icon: Symbols.shopping_bag_rounded,
                tooltip: context.loc.tab_bag,
                variant: t < 1
                    ? SdIconButtonVariantV5.floating
                    : SdIconButtonVariantV5.plain,
                size: SdSpacingConstant.r40,
                badgeCount: bagCount,
                onPressed: () => context.go(AppRoutes.cart.path),
              ),
            ],
          ),
        );
      },
    );
  }
}
