import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import '../../widgets/order_labels.dart';

/// The status in large type with its glyph, the date that matters for it,
/// and a four-step progress bar that fills on arrival.
class OrderStatusHeader extends StatelessWidget {
  const OrderStatusHeader({required this.order, super.key});

  final OrderEntity order;

  static const List<OrderStatus> _steps = <OrderStatus>[
    OrderStatus.processing,
    OrderStatus.shipped,
    OrderStatus.outForDelivery,
    OrderStatus.delivered,
  ];

  @override
  Widget build(BuildContext context) {
    final bool cancelled = order.status == OrderStatus.cancelled;
    final int reached = cancelled ? -1 : _steps.indexOf(order.status);
    final Color tint = switch (orderStatusTone(order.status)) {
      SdBadgeToneV5.success => context.sdTheme5.success,
      SdBadgeToneV5.danger => context.sdTheme5.danger,
      SdBadgeToneV5.warning => context.sdTheme5.warning,
      _ => context.sdTheme5.info,
    };
    final String date = Formatters.date(
      order.estimatedDelivery,
      context.localeName,
    );

    return SdCardV5(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: SdSpacingConstant.r48,
                height: SdSpacingConstant.r48,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SdIconV5(
                    orderStatusIcon(order.status),
                    color: tint,
                    fill: 1,
                  ),
                ),
              ),
              SizedBox(width: SdSpacingConstant.w14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      context.orderStatusLabel(order.status),
                      style: context.textTheme5.titleLarge,
                    ),
                    Text(switch (order.status) {
                      OrderStatus.delivered => context.loc.order_delivered_on(
                        date,
                      ),
                      OrderStatus.cancelled => context.loc.order_cancelled_note,
                      _ => context.loc.order_arriving(date),
                    }, style: context.textTheme5.bodySmall!.muted5(context)),
                  ],
                ),
              ),
            ],
          ),
          if (!cancelled) ...<Widget>[
            SizedBox(height: SdSpacingConstant.h16),
            Row(
              children: <Widget>[
                for (int i = 0; i < _steps.length; i++) ...<Widget>[
                  if (i > 0) SizedBox(width: SdSpacingConstant.w4),
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: i <= reached ? 1 : 0),
                      duration:
                          SdMotionV5.of(context, SdMotionV5.slow) *
                          (1 + i * 0.5),
                      curve: SdMotionV5.standard,
                      builder: (BuildContext context, double v, Widget? _) =>
                          ClipRRect(
                            borderRadius: SdRadiusV5.fullAll,
                            child: LinearProgressIndicator(
                              value: v,
                              minHeight: SdSpacingConstant.h6,
                              color: tint,
                              backgroundColor: context.sdTheme5.surfaceSunken,
                            ),
                          ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
