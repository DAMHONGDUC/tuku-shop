import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/order_entity.dart';
import '../usecases/place_order_usecase.dart';

abstract class OrderRepository {
  /// Newest first.
  Future<Either<Failure, List<OrderEntity>>> getOrders();

  Future<Either<Failure, OrderEntity>> getOrder(String id);

  Future<Either<Failure, OrderEntity>> placeOrder(PlaceOrderParams params);

  Future<Either<Failure, OrderEntity>> cancelOrder(String id);
}
