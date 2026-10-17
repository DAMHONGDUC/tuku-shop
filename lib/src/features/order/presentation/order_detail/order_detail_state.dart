part of 'order_detail_controller.dart';

class OrderDetailState extends Equatable {
  const OrderDetailState({
    this.status = LoadStatus.loading,
    this.order,
    this.busy = false,
  });

  final LoadStatus status;
  final OrderEntity? order;
  final bool busy;

  OrderDetailState copyWith({bool? busy}) =>
      OrderDetailState(status: status, order: order, busy: busy ?? this.busy);

  @override
  List<Object?> get props => <Object?>[status, order, busy];
}
