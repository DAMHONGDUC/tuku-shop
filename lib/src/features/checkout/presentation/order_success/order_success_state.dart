part of 'order_success_controller.dart';

class OrderSuccessState extends Equatable {
  const OrderSuccessState({this.status = LoadStatus.loading, this.order});

  final LoadStatus status;
  final OrderEntity? order;

  @override
  List<Object?> get props => <Object?>[status, order];
}
