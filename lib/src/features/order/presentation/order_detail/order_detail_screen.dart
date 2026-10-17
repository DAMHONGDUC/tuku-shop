import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import 'components/order_actions.dart';
import 'components/order_status_header.dart';
import 'components/order_tracking.dart';
import 'order_detail_controller.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({required this.orderId, super.key});

  final String orderId;

  @override
  Widget build(BuildContext context) => BlocProvider<OrderDetailController>(
    create: (BuildContext _) => getIt<OrderDetailController>()..load(orderId),
    child: BlocBuilder<OrderDetailController, OrderDetailState>(
      builder: (BuildContext context, OrderDetailState state) => SdScaffoldV5(
        appBar: SdAppBarV5(
          title: state.order?.code ?? context.loc.order_detail_title,
        ),
        body: FadeSwitcher(
          child: switch (state.status) {
            LoadStatus.loading => const Center(child: SdLoadingV5()),
            LoadStatus.failure => ErrorView(
              onRetry: () =>
                  context.read<OrderDetailController>().load(orderId),
            ),
            LoadStatus.success => _Body(order: state.order!),
          },
        ),
      ),
    ),
  );
}

class _Body extends StatelessWidget {
  const _Body({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final double gap = SdContentPaddingV5.sectionGap * 0.8;

    return ListView(
      padding: SdContentPaddingV5.gutter.copyWith(
        top: SdSpacingConstant.h8,
        bottom: SdContentPaddingV5.detailBottom(context),
      ),
      children: <Widget>[
        SdFadeInV5(child: OrderStatusHeader(order: order)),
        SizedBox(height: gap),
        SdFadeInV5(index: 1, child: OrderTracking(order: order)),
        SizedBox(height: gap),
        SdFadeInV5(
          index: 2,
          child: _Section(
            title: context.loc.checkout_items(order.itemCount),
            child: Column(
              children: <Widget>[
                for (final OrderItemEntity i in order.items)
                  Padding(
                    padding: EdgeInsets.only(bottom: SdSpacingConstant.h12),
                    child: SdPressableV5(
                      onTap: () =>
                          context.push(AppRoutes.productPath(i.productId)),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: SdSpacingConstant.w56,
                            height: SdSpacingConstant.w56 / 0.8,
                            child: AppImage(
                              i.image,
                              borderRadius: SdRadiusV5.thumbnailAll,
                            ),
                          ),
                          SizedBox(width: SdSpacingConstant.w12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  i.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme5.titleSmall,
                                ),
                                SizedBox(height: SdSpacingConstant.h2),
                                Text(
                                  context.loc.review_variant(i.size, i.color),
                                  style: context.textTheme5.bodySmall!.muted5(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                Formatters.currency(i.lineTotal),
                                style: context.textTheme5.labelLarge!.tabular5,
                              ),
                              Text(
                                '${i.quantity} × ${Formatters.currency(i.unitPrice)}',
                                style: context.textTheme5.labelSmall!.faint5(
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: gap),
        SdFadeInV5(
          index: 3,
          child: _Section(
            title: context.loc.order_shipping_info,
            child: SdCardV5(
              layer: SdCardLayerV5.sunken,
              child: Column(
                children: <Widget>[
                  _InfoRow(
                    icon: Symbols.person_rounded,
                    text: '${order.recipient}  ·  ${order.phone}',
                  ),
                  SizedBox(height: SdSpacingConstant.h10),
                  _InfoRow(
                    icon: Symbols.location_on_rounded,
                    text: order.address,
                  ),
                  SizedBox(height: SdSpacingConstant.h10),
                  _InfoRow(
                    icon: Symbols.credit_card_rounded,
                    text: order.paymentType == PaymentMethodType.cashOnDelivery
                        ? context.loc.payment_cod
                        : order.paymentLabel,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: gap),
        SdFadeInV5(
          index: 4,
          child: OrderSummaryCard(
            subtotal: order.subtotal,
            discount: order.discount,
            shipping: order.shippingFee,
            total: order.total,
            promoCode: order.promoCode,
          ),
        ),
        SizedBox(height: gap),
        SdFadeInV5(index: 5, child: OrderActions(order: order)),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Text(title, style: context.textTheme5.titleMedium),
      SizedBox(height: SdSpacingConstant.h12),
      child,
    ],
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SdIconV5(
        icon,
        size: SdIconV5.smallSize * 1.1,
        color: context.sdTheme5.textSecondary,
      ),
      SizedBox(width: SdSpacingConstant.w12),
      Expanded(child: Text(text, style: context.textTheme5.bodyMedium)),
    ],
  );
}
