import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class ClearCartUsecase implements UseCase<CartEntity, NoParams> {
  ClearCartUsecase(this.repository);

  final CartRepository repository;

  @override
  Future<Either<Failure, CartEntity>> call(NoParams params) =>
      repository.clear();
}
