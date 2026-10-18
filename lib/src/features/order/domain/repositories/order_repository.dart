import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrdersPage>> getOrders(OrdersQuery query);

  Future<Either<Failure, OrderEntity>> getOrderDetail(String orderId);

  /// How many orders are in each status.
  Future<Either<Failure, Map<OrderStatus, int>>> getOrderCounts();

  Future<Either<Failure, OrderEntity>> placeOrder(NewOrder order);

  Future<Either<Failure, OrderEntity>> cancelOrder(String orderId);

  /// Ticks after an order is placed or changed.
  Stream<void> watchChanges();

  Future<Either<Failure, Unit>> reset();
}
