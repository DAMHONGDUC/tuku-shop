import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrdersUsecase implements UseCase<List<OrderEntity>, NoParams> {
  GetOrdersUsecase(this.repository);

  final OrderRepository repository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call(NoParams params) =>
      repository.getOrders();
}
