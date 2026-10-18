part of 'orders_list_controller.dart';

enum OrdersListStatus { loading, loaded, error }

class OrdersListState extends Equatable {
  final OrdersListStatus status;
  final List<OrderEntity> items;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  const OrdersListState({
    this.status = OrdersListStatus.loading,
    this.items = const [],
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [status, items, page, hasMore, isLoadingMore];
}
