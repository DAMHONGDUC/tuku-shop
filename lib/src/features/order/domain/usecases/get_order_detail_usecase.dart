import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderDetailUsecase implements UseCase<OrderEntity, String> {
  GetOrderDetailUsecase(this.repository);

  final OrderRepository repository;

  @override
  Future<Either<Failure, OrderEntity>> call(String params) =>
      repository.getOrder(params);
}
