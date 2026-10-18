enum OrderStatus {
  waitingForConfirmation,
  waitingForPickup,
  waitingForDelivery,
  delivered,
  rolledBack,
  cancelled,
  none,
}

/// Labels and colors live with the screens (`OrderStatusL10n`), so they
/// follow the language and the theme.
extension OrderStatusExt on OrderStatus {
  static const OrderStatus defaultFirstTab = OrderStatus.waitingForConfirmation;

  /// The order tabs, in the order a purchase moves through them.
  static List<OrderStatus> get tabs => const [
    OrderStatus.waitingForConfirmation,
    OrderStatus.waitingForPickup,
    OrderStatus.waitingForDelivery,
    OrderStatus.delivered,
    OrderStatus.cancelled,
    OrderStatus.rolledBack,
  ];

  static OrderStatus fromIndex(int index) =>
      index >= 0 && index < tabs.length ? tabs[index] : OrderStatus.none;
}
