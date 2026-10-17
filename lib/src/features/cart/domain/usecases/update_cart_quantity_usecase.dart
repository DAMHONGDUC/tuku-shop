import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateCartQuantityParams extends Equatable {
  const UpdateCartQuantityParams({
    required this.itemId,
    required this.quantity,
  });

  final String itemId;
  final int quantity;

  @override
  List<Object> get props => <Object>[itemId, quantity];
}

class UpdateCartQuantityUsecase
    implements UseCase<CartEntity, UpdateCartQuantityParams> {
  UpdateCartQuantityUsecase(this.repository);

  final CartRepository repository;

  @override
  Future<Either<Failure, CartEntity>> call(UpdateCartQuantityParams params) =>
      params.quantity <= 0
      ? repository.remove(params.itemId)
      : repository.updateQuantity(params.itemId, params.quantity);
}
