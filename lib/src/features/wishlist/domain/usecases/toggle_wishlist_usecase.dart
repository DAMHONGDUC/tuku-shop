import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/wishlist_repository.dart';

class ToggleWishlistUsecase implements UseCase<bool, String> {
  ToggleWishlistUsecase(this.repository);

  final WishlistRepository repository;

  @override
  Future<Either<Failure, bool>> call(String params) =>
      repository.toggle(params);
}
