import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

class GetOrdersUsecase implements UseCase<OrdersPage, OrdersQuery> {
  final OrderRepository repository;

  GetOrdersUsecase(this.repository);

  @override
  Future<Either<Failure, OrdersPage>> call(OrdersQuery params) =>
      repository.getOrders(params);
}

class GetOrderDetailUsecase implements UseCase<OrderEntity, String> {
  final OrderRepository repository;

  GetOrderDetailUsecase(this.repository);

  @override
  Future<Either<Failure, OrderEntity>> call(String params) =>
      repository.getOrderDetail(params);
}

class GetOrderCountsUsecase
    implements UseCase<Map<OrderStatus, int>, NoParams> {
  final OrderRepository repository;

  GetOrderCountsUsecase(this.repository);

  @override
  Future<Either<Failure, Map<OrderStatus, int>>> call(NoParams params) =>
      repository.getOrderCounts();
}

class PlaceOrderUsecase implements UseCase<OrderEntity, NewOrder> {
  final OrderRepository repository;

  PlaceOrderUsecase(this.repository);

  @override
  Future<Either<Failure, OrderEntity>> call(NewOrder params) {
    if (params.items.isEmpty) {
      return Future.value(const Left(ValidationFailure('empty_order')));
    }
    return repository.placeOrder(params);
  }
}

class CancelOrderUsecase implements UseCase<OrderEntity, String> {
  final OrderRepository repository;

  CancelOrderUsecase(this.repository);

  @override
  Future<Either<Failure, OrderEntity>> call(String params) =>
      repository.cancelOrder(params);
}

class WatchOrderChangesUsecase {
  final OrderRepository repository;

  WatchOrderChangesUsecase(this.repository);

  Stream<void> call() => repository.watchChanges();
}

class ResetOrdersUsecase implements UseCase<Unit, NoParams> {
  final OrderRepository repository;

  ResetOrdersUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.reset();
}
