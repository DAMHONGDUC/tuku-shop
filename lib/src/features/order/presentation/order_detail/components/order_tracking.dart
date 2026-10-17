import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import '../../widgets/order_labels.dart';

/// Every step the order passes through, with the ones reached stamped with
/// where and when.
class OrderTracking extends StatelessWidget {
  const OrderTracking({required this.order, super.key});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final List<OrderStatus> path = order.status == OrderStatus.cancelled
        ? <OrderStatus>[OrderStatus.placed, OrderStatus.cancelled]
        : <OrderStatus>[
            OrderStatus.placed,
            OrderStatus.processing,
            OrderStatus.shipped,
            OrderStatus.outForDelivery,
            OrderStatus.delivered,
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(context.loc.order_tracking, style: context.textTheme5.titleMedium),
        SizedBox(height: SdSpacingConstant.h16),
        SdTimelineV5(
          steps: <SdTimelineStepV5>[
            for (final OrderStatus status in path)
              () {
                final TrackingEventEntity? event = order.tracking.firstWhereOrNull(
                  (TrackingEventEntity e) => e.status == status,
                );

                return SdTimelineStepV5(
                  title: context.orderStatusLabel(status),
                  subtitle: event?.location,
                  trailing: event == null
                      ? null
                      : Formatters.dateTime(event.time, context.localeName),
                  state: event == null
                      ? SdTimelineStateV5.upcoming
                      : status == order.status
                      ? (status == OrderStatus.delivered
                            ? SdTimelineStateV5.done
                            : SdTimelineStateV5.current)
                      : SdTimelineStateV5.done,
                );
              }(),
          ],
        ),
      ],
    );
  }
}
