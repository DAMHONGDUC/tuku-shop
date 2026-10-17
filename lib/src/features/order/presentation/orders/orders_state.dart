part of 'orders_controller.dart';

enum OrdersFilter { all, active, delivered, cancelled }

class OrdersState extends Equatable {
  const OrdersState({
    this.status = LoadStatus.loading,
    this.orders = const <OrderEntity>[],
    this.filter = OrdersFilter.all,
  });

  final LoadStatus status;
  final List<OrderEntity> orders;
  final OrdersFilter filter;

  List<OrderEntity> get visible => switch (filter) {
    OrdersFilter.all => orders,
    OrdersFilter.active => orders.where((OrderEntity o) => o.status.isActive).toList(),
    OrdersFilter.delivered =>
      orders.where((OrderEntity o) => o.status == OrderStatus.delivered).toList(),
    OrdersFilter.cancelled =>
      orders.where((OrderEntity o) => o.status == OrderStatus.cancelled).toList(),
  };

  OrdersState copyWith({
    LoadStatus? status,
    List<OrderEntity>? orders,
    OrdersFilter? filter,
  }) => OrdersState(
    status: status ?? this.status,
    orders: orders ?? this.orders,
    filter: filter ?? this.filter,
  );

  @override
  List<Object> get props => <Object>[status, orders, filter];
}
