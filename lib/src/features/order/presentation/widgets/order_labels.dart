import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Words, glyph and tone for each [OrderStatus].
extension OrderLabels on BuildContext {
  String orderStatusLabel(OrderStatus status) => switch (status) {
    OrderStatus.placed => loc.order_status_placed,
    OrderStatus.processing => loc.order_status_processing,
    OrderStatus.shipped => loc.order_status_shipped,
    OrderStatus.outForDelivery => loc.order_status_out,
    OrderStatus.delivered => loc.order_status_delivered,
    OrderStatus.cancelled => loc.order_status_cancelled,
  };
}

IconData orderStatusIcon(OrderStatus status) => switch (status) {
  OrderStatus.placed => Symbols.receipt_long_rounded,
  OrderStatus.processing => Symbols.inventory_2_rounded,
  OrderStatus.shipped => Symbols.local_shipping_rounded,
  OrderStatus.outForDelivery => Symbols.delivery_truck_speed_rounded,
  OrderStatus.delivered => Symbols.check_circle_rounded,
  OrderStatus.cancelled => Symbols.cancel_rounded,
};

SdBadgeToneV5 orderStatusTone(OrderStatus status) => switch (status) {
  OrderStatus.delivered => SdBadgeToneV5.success,
  OrderStatus.cancelled => SdBadgeToneV5.danger,
  OrderStatus.placed || OrderStatus.processing => SdBadgeToneV5.warning,
  _ => SdBadgeToneV5.info,
};
