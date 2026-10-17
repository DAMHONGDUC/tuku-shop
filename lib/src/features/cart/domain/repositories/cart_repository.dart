import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/cart_entity.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  /// The bag, replayed to each new listener.
  Stream<CartEntity> watch();

  Future<Either<Failure, CartEntity>> add(CartItemEntity item);

  Future<Either<Failure, CartEntity>> updateQuantity(String itemId, int quantity);

  Future<Either<Failure, CartEntity>> remove(String itemId);

  Future<Either<Failure, CartEntity>> applyPromo(String code);

  Future<Either<Failure, CartEntity>> removePromo();

  Future<Either<Failure, CartEntity>> clear();
}
