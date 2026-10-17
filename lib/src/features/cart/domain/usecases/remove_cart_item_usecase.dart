import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class RemoveCartItemUsecase implements UseCase<CartEntity, String> {
  RemoveCartItemUsecase(this.repository);

  final CartRepository repository;

  @override
  Future<Either<Failure, CartEntity>> call(String params) =>
      repository.remove(params);
}
