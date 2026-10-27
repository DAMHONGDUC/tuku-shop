import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/entities/order_entity.dart';

class OrdersQuery extends Equatable {
  final OrderStatus status;
  final int page;
  final int pageSize;

  const OrdersQuery({required this.status, this.page = 1, this.pageSize = 10});

  OrdersQuery nextPage() =>
      OrdersQuery(status: status, page: page + 1, pageSize: pageSize);

  @override
  List<Object?> get props => [status, page, pageSize];
}

class OrdersPage extends Equatable {
  final List<OrderEntity> items;
  final int currentPage;
  final int totalPage;
  final int totalRecord;

  const OrdersPage({
    required this.items,
    required this.currentPage,
    required this.totalPage,
    required this.totalRecord,
  });

  bool get hasMore => currentPage < totalPage;

  @override
  List<Object?> get props => [items, currentPage, totalPage, totalRecord];
}
