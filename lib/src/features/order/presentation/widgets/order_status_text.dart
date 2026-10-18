import 'package:flutter/material.dart';
import 'package:tuku_shop/src/core/core.dart';

/// User-facing words and color for an order status.
extension OrderStatusL10n on OrderStatus {
  String label(BuildContext context) => switch (this) {
    OrderStatus.waitingForConfirmation => context.loc.order_status_to_confirm,
    OrderStatus.waitingForPickup => context.loc.order_status_to_ship,
    OrderStatus.waitingForDelivery => context.loc.order_status_on_the_way,
    OrderStatus.delivered => context.loc.order_status_delivered,
    OrderStatus.cancelled => context.loc.order_status_cancelled,
    OrderStatus.rolledBack => context.loc.order_status_returned,
    OrderStatus.none => '',
  };

  /// The confident one-liner at the top of the order page.
  String headline(BuildContext context) => switch (this) {
    OrderStatus.waitingForConfirmation => context.loc.order_headline_to_confirm,
    OrderStatus.waitingForPickup => context.loc.order_headline_to_ship,
    OrderStatus.waitingForDelivery => context.loc.order_headline_on_the_way,
    OrderStatus.delivered => context.loc.order_headline_delivered,
    OrderStatus.cancelled => context.loc.order_headline_cancelled,
    OrderStatus.rolledBack => context.loc.order_headline_returned,
    OrderStatus.none => '',
  };

  Color tone(BuildContext context) {
    final colors = context.colorTheme;
    return switch (this) {
      OrderStatus.waitingForConfirmation => colors.warning,
      OrderStatus.waitingForPickup => colors.primary,
      OrderStatus.waitingForDelivery => colors.primary,
      OrderStatus.delivered => colors.success,
      OrderStatus.cancelled => colors.sale,
      OrderStatus.rolledBack => colors.textSubTitle,
      OrderStatus.none => colors.textSubTitle,
    };
  }
}
