part of 'order_detail_controller.dart';

enum OrderDetailStatus { loading, loaded, error }

enum OrderAction {
  none,
  cancelling,
  cancelled,
  cancelFailed,
  reordering,
  reordered,
  reorderFailed,
}

class OrderDetailState extends Equatable {
  final OrderDetailStatus status;
  final OrderEntity? order;
  final OrderAction action;

  const OrderDetailState({
    this.status = OrderDetailStatus.loading,
    this.order,
    this.action = OrderAction.none,
  });

  OrderDetailState copyWith({
    OrderDetailStatus? status,
    OrderEntity? order,
    OrderAction? action,
  }) {
    return OrderDetailState(
      status: status ?? this.status,
      order: order ?? this.order,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props => [status, order, action];
}
