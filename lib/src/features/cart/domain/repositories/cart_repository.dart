import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/entities/cart_line.dart';

abstract class CartRepository {
  /// Emits the full cart after every change.
  Stream<List<CartLine>> watchLines();

  Future<Either<Failure, List<CartLine>>> getLines();

  /// Adds [line]; an existing line for the same variant grows instead,
  /// capped at its max quantity.
  Future<Either<Failure, List<CartLine>>> add(CartLine line);

  Future<Either<Failure, List<CartLine>>> updateQuantity(
    String lineId,
    int quantity,
  );

  Future<Either<Failure, List<CartLine>>> remove(String lineId);

  /// Removes the given lines, e.g. after they were ordered.
  Future<Either<Failure, List<CartLine>>> removeLines(Set<String> lineIds);

  /// Back to the first-launch demo cart.
  Future<Either<Failure, Unit>> reset();
}
