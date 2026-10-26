import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/order/presentation/widgets/order_status_text.dart';

import 'order_detail_controller.dart';

/// One order: status headline, timeline, items, delivery and payment.
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrderDetailController>()..load(orderId),
      child: _View(orderId: orderId),
    );
  }
}

class _View extends StatelessWidget {
  const _View({required this.orderId});

  final String orderId;

  Future<void> _confirmCancel(BuildContext context) async {
    final controller = context.read<OrderDetailController>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.loc.order_cancel_title),
        content: Text(context.loc.order_cancel_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(context.loc.order_cancel_keep),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              context.loc.order_cancel_confirm,
              style: TextStyle(color: context.colorTheme.sale),
            ),
          ),
        ],
      ),
    );
    if (ok == true) controller.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BlocConsumer<OrderDetailController, OrderDetailState>(
      listenWhen: (a, b) => a.action != b.action,
      listener: (context, state) {
        final toast = AppToast.of(context);
        switch (state.action) {
          case OrderAction.cancelled:
            toast.show(
              context.loc.order_cancelled_toast,
              type: AppToastType.success,
            );
          case OrderAction.reordered:
            context.push(CartRoutes.cart.fullPath);
          case OrderAction.cancelFailed || OrderAction.reorderFailed:
            toast.show(
              context.loc.common_load_failed,
              type: AppToastType.error,
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        final order = state.order;
        return Scaffold(
          backgroundColor: colors.pageDefault,
          appBar: AppTopBar(
            title: order == null ? context.loc.orders_title : '#${order.id}',
            actions: [
              AppIconButton(
                icon: Icons.support_agent_rounded,
                label: context.loc.support_title,
                onTap: () => context.push(SupportChatRoutes.chat.fullPath),
              ),
            ],
          ),
          bottomNavigationBar: order == null
              ? null
              : _Dock(
                  order: order,
                  action: state.action,
                  onCancel: () => _confirmCancel(context),
                ),
          body: switch (state.status) {
            OrderDetailStatus.loading => ListView(
              padding: EdgeInsets.all(SdSpacingV5.s16),
              children: [
                const SkeletonBox(height: 72, radius: UIConstants.cardRadius),
                SdVerticalSpacingV5(value: SdSpacingV5.s12),
                const SkeletonBox(height: 180, radius: UIConstants.cardRadius),
                SdVerticalSpacingV5(value: SdSpacingV5.s12),
                const SkeletonBox(height: 120, radius: UIConstants.cardRadius),
              ],
            ),
            OrderDetailStatus.error => Padding(
              padding: EdgeInsets.all(SdSpacingV5.s16),
              child: SectionError(
                onRetry: () =>
                    context.read<OrderDetailController>().load(orderId),
              ),
            ),
            OrderDetailStatus.loaded => _Body(order: order!),
          },
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final card = BoxDecoration(
      color: colors.cardDefault,
      borderRadius: BorderRadius.circular(UIConstants.cardRadius),
    );
    final label = SdTextStyleV5.body12().wColor(colors.textSubTitle);
    final value = SdTextStyleV5.body14().wColor(colors.textDefault);
    final showEta =
        order.status != OrderStatus.cancelled &&
        order.status != OrderStatus.rolledBack &&
        order.status != OrderStatus.delivered;

    return ListView(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      children: [
        Container(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          decoration: BoxDecoration(
            color: order.status.tone(context).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(UIConstants.cardRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.status.headline(context),
                style: SdTextStyleV5.heading16().wColor(colors.textDefault),
              ),
              if (showEta) ...[
                SdVerticalSpacingV5(value: SdSpacingV5.s4),
                Text(
                  context.loc.order_eta(
                    DateFormat.MMMEd(locale).format(order.estimatedDelivery),
                  ),
                  style: label,
                ),
              ],
            ],
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Container(
          decoration: card,
          padding: EdgeInsets.all(SdSpacingV5.s16),
          child: _Timeline(order: order),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Container(
          decoration: card,
          padding: EdgeInsets.all(SdSpacingV5.s16),
          child: Column(
            children: [
              for (final item in order.items)
                Padding(
                  padding: EdgeInsets.only(bottom: SdSpacingV5.s12),
                  child: InkWell(
                    onTap: () => context.push(
                      ProductRoutes.productDetailLocation(item.productId),
                    ),
                    child: Row(
                      children: [
                        CatalogImage(
                          path: item.imageUrl,
                          width: 56,
                          height: 70,
                          borderRadius: SdSpacingV5.s8,
                        ),
                        SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name, style: value),
                              Text(
                                '${item.colorName} · ${item.size} · ×${item.quantity}',
                                style: label,
                              ),
                            ],
                          ),
                        ),
                        PriceText(price: item.total),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Container(
          decoration: card,
          padding: EdgeInsets.all(SdSpacingV5.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.loc.checkout_ship_to, style: label),
              SdVerticalSpacingV5(value: SdSpacingV5.s4),
              Text(
                '${order.shipTo.fullName} · ${order.shipTo.phone}',
                style: value,
              ),
              Text(order.shipTo.address, style: label),
              SdVerticalSpacingV5(value: SdSpacingV5.s12),
              Text(context.loc.checkout_payment, style: label),
              SdVerticalSpacingV5(value: SdSpacingV5.s4),
              Text(
                '${order.paymentMethod} · ${order.shippingMethod}',
                style: value,
              ),
              Divider(height: SdSpacingV5.s24, color: colors.borderDefault),
              _row(
                context,
                context.loc.cart_subtotal,
                AppFormat.price(order.subtotal),
              ),
              if (order.discount > 0)
                _row(
                  context,
                  order.voucherCode == null
                      ? context.loc.checkout_discount
                      : '${context.loc.checkout_discount} (${order.voucherCode})',
                  '−${AppFormat.price(order.discount)}',
                ),
              _row(
                context,
                context.loc.cart_shipping,
                order.shippingFee == 0
                    ? context.loc.checkout_free
                    : AppFormat.price(order.shippingFee),
              ),
              _row(
                context,
                context.loc.cart_total,
                AppFormat.price(order.total),
                bold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(BuildContext context, String l, String v, {bool bold = false}) {
    final colors = context.colorTheme;
    final style = bold ? SdTextStyleV5.heading16() : SdTextStyleV5.body14();
    return Padding(
      padding: EdgeInsets.only(bottom: SdSpacingV5.s4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l,
            style: style.wColor(
              bold ? colors.textDefault : colors.textSubTitle,
            ),
          ),
          Text(
            v,
            style: style.copyWith(
              color: colors.textDefault,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

/// The steps an order goes through; done steps carry their time.
class _Timeline extends StatelessWidget {
  const _Timeline({required this.order});

  final OrderEntity order;

  static const _happyPath = [
    OrderStatus.waitingForConfirmation,
    OrderStatus.waitingForPickup,
    OrderStatus.waitingForDelivery,
    OrderStatus.delivered,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final reached = {for (final e in order.events) e.status: e.at};
    // A cancelled or returned order ends where it stopped.
    final steps =
        order.status == OrderStatus.cancelled ||
            order.status == OrderStatus.rolledBack
        ? order.events.map((e) => e.status).toList()
        : _happyPath;

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: SdSpacingV5.s20,
                  child: Column(
                    children: [
                      Container(
                        width: SdSpacingV5.s14,
                        height: SdSpacingV5.s14,
                        margin: EdgeInsets.only(top: SdSpacingV5.s2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: steps[i] == order.status
                              ? steps[i].tone(context)
                              : reached.containsKey(steps[i])
                              ? colors.success
                              : colors.borderDefault,
                          boxShadow: steps[i] == order.status
                              ? [
                                  BoxShadow(
                                    color: steps[i]
                                        .tone(context)
                                        .withValues(alpha: 0.2),
                                    spreadRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      if (i < steps.length - 1)
                        Expanded(
                          child: Container(
                            width: 2,
                            color: reached.containsKey(steps[i + 1])
                                ? colors.success
                                : colors.borderDefault,
                          ),
                        ),
                    ],
                  ),
                ),
                SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: SdSpacingV5.s16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].label(context),
                          style:
                              (reached.containsKey(steps[i])
                                      ? SdTextStyleV5.body14().wSemiBold()
                                      : SdTextStyleV5.body14())
                                  .wColor(
                                    reached.containsKey(steps[i])
                                        ? colors.textDefault
                                        : colors.textSubTitle,
                                  ),
                        ),
                        if (reached[steps[i]] case final at?)
                          Text(
                            DateFormat.MMMd(locale).add_Hm().format(at),
                            style: SdTextStyleV5.body12().wColor(
                              colors.textSubTitle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Dock extends StatelessWidget {
  const _Dock({
    required this.order,
    required this.action,
    required this.onCancel,
  });

  final OrderEntity order;
  final OrderAction action;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<OrderDetailController>();

    return BottomActionBar(
      child: Row(
        children: [
          if (order.canCancel) ...[
            Expanded(
              child: AppButton(
                label: context.loc.order_cancel,
                style: AppButtonStyle.soft,
                isLoading: action == OrderAction.cancelling,
                onTap: onCancel,
              ),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s12),
          ],
          Expanded(
            child: AppButton(
              label: context.loc.order_buy_again,
              leadingIcon: Icons.refresh_rounded,
              isLoading: action == OrderAction.reordering,
              onTap: controller.buyAgain,
            ),
          ),
        ],
      ),
    );
  }
}
