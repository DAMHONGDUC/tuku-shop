import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlistIdsUsecase implements UseCase<List<String>, NoParams> {
  final WishlistRepository repository;

  GetWishlistIdsUsecase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) =>
      repository.getIds();
}

/// A stream, not an `Either`: badges and hearts follow every change.
class WatchWishlistIdsUsecase {
  final WishlistRepository repository;

  WatchWishlistIdsUsecase(this.repository);

  Stream<List<String>> call() => repository.watchIds();
}

class ToggleWishlistUsecase implements UseCase<bool, String> {
  final WishlistRepository repository;

  ToggleWishlistUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) =>
      repository.toggle(params);
}

class ResetWishlistUsecase implements UseCase<Unit, NoParams> {
  final WishlistRepository repository;

  ResetWishlistUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.reset();
}
