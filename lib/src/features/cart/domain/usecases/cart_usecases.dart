import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/entities/cart_line.dart';
import 'package:tuku_shop/src/features/cart/domain/repositories/cart_repository.dart';

class GetCartUsecase implements UseCase<List<CartLine>, NoParams> {
  final CartRepository repository;

  GetCartUsecase(this.repository);

  @override
  Future<Either<Failure, List<CartLine>>> call(NoParams params) =>
      repository.getLines();
}

/// A stream, not an `Either`: the badge and the cart follow every change.
class WatchCartUsecase {
  final CartRepository repository;

  WatchCartUsecase(this.repository);

  Stream<List<CartLine>> call() => repository.watchLines();
}

class AddToCartUsecase implements UseCase<List<CartLine>, CartLine> {
  final CartRepository repository;

  AddToCartUsecase(this.repository);

  @override
  Future<Either<Failure, List<CartLine>>> call(CartLine params) {
    if (params.quantity < 1 || params.quantity > params.maxQuantity) {
      return Future.value(const Left(ValidationFailure('invalid_quantity')));
    }
    return repository.add(params);
  }
}

class UpdateCartQuantityUsecase
    implements UseCase<List<CartLine>, UpdateCartQuantityParams> {
  final CartRepository repository;

  UpdateCartQuantityUsecase(this.repository);

  @override
  Future<Either<Failure, List<CartLine>>> call(
    UpdateCartQuantityParams params,
  ) {
    if (params.quantity < 1) return repository.remove(params.lineId);
    return repository.updateQuantity(params.lineId, params.quantity);
  }
}

class UpdateCartQuantityParams extends Equatable {
  final String lineId;
  final int quantity;

  const UpdateCartQuantityParams({
    required this.lineId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [lineId, quantity];
}

class RemoveCartLineUsecase implements UseCase<List<CartLine>, String> {
  final CartRepository repository;

  RemoveCartLineUsecase(this.repository);

  @override
  Future<Either<Failure, List<CartLine>>> call(String params) =>
      repository.remove(params);
}

class RemoveCartLinesUsecase implements UseCase<List<CartLine>, Set<String>> {
  final CartRepository repository;

  RemoveCartLinesUsecase(this.repository);

  @override
  Future<Either<Failure, List<CartLine>>> call(Set<String> params) =>
      repository.removeLines(params);
}

class ResetCartUsecase implements UseCase<Unit, NoParams> {
  final CartRepository repository;

  ResetCartUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.reset();
}
