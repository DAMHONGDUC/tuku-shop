/// Where an order is in its life, in the order it moves through them.
enum OrderStatus {
  placed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  cancelled;

  static OrderStatus fromName(String? value) => OrderStatus.values.firstWhere(
    (OrderStatus e) => e.name == value,
    orElse: () => OrderStatus.placed,
  );

  /// Still on its way — the "Active" tab of My Orders.
  bool get isActive =>
      this != OrderStatus.delivered && this != OrderStatus.cancelled;

  /// A customer may still cancel it.
  bool get isCancellable =>
      this == OrderStatus.placed || this == OrderStatus.processing;
}
