import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class ApplyPromoUsecase implements UseCase<CartEntity, String> {
  ApplyPromoUsecase(this.repository);

  final CartRepository repository;

  @override
  Future<Either<Failure, CartEntity>> call(String params) =>
      repository.applyPromo(params.trim().toUpperCase());
}
