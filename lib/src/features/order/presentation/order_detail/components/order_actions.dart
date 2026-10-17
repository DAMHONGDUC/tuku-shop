import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import '../order_detail_controller.dart';

/// What can be done with the order now: cancel while it is still being
/// prepared, buy again and review once it has arrived, get help always.
class OrderActions extends StatelessWidget {
  const OrderActions({required this.order, super.key});

  final OrderEntity order;

  Future<void> _confirmCancel(BuildContext context) => showSdDialogV5<void>(
    context,
    SdDialogV5(
      icon: Symbols.cancel_rounded,
      iconColor: context.sdTheme5.danger,
      title: context.loc.order_cancel_title,
      message: context.loc.order_cancel_message,
      actions: <SdDialogActionV5>[
        SdDialogActionV5(
          label: context.loc.order_cancel_confirm,
          variant: SdButtonVariantV5.destructive,
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            final bool ok = await context
                .read<OrderDetailController>()
                .cancel();
            if (context.mounted && ok) {
              SdSnackBarUtilsV5.success(
                context,
                context.loc.order_cancelled_toast,
              );
            }
          },
        ),
        SdDialogActionV5(
          label: context.loc.order_keep,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
    ),
  );

  Future<void> _buyAgain(BuildContext context) async {
    await context.read<OrderDetailController>().buyAgain();
    if (context.mounted) {
      SdSnackBarUtilsV5.success(context, context.loc.order_bought_again);
      context.go(AppRoutes.cart.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool busy = context.select<OrderDetailController, bool>(
      (OrderDetailController c) => c.state.busy,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (order.status == OrderStatus.delivered ||
            order.status == OrderStatus.cancelled) ...<Widget>[
          SdButtonV5(
            variant: SdButtonVariantV5.primary,
            label: context.loc.order_buy_again,
            icon: Symbols.replay_rounded,
            expand: true,
            busy: busy,
            onPressed: () => _buyAgain(context),
          ),
          SizedBox(height: SdSpacingConstant.h10),
        ],
        if (order.status == OrderStatus.delivered) ...<Widget>[
          SdButtonV5(
            variant: SdButtonVariantV5.outlined,
            label: context.loc.order_write_review,
            icon: Symbols.rate_review_rounded,
            expand: true,
            onPressed: () => SdSnackBarUtilsV5.info(
              context,
              context.loc.order_review_thanks,
            ),
          ),
          SizedBox(height: SdSpacingConstant.h10),
        ],
        if (order.status.isCancellable) ...<Widget>[
          SdButtonV5(
            variant: SdButtonVariantV5.outlined,
            label: context.loc.order_cancel,
            icon: Symbols.close_rounded,
            expand: true,
            busy: busy,
            onPressed: () => _confirmCancel(context),
          ),
          SizedBox(height: SdSpacingConstant.h10),
        ],
        SdButtonV5(
          variant: SdButtonVariantV5.text,
          label: context.loc.order_help,
          icon: Symbols.support_agent_rounded,
          expand: true,
          onPressed: () => context.push(AppRoutes.helpCenter.path),
        ),
      ],
    );
  }
}
