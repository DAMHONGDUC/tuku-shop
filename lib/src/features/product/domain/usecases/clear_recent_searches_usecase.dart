import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/product_repository.dart';

class ClearRecentSearchesUsecase implements UseCase<Unit, NoParams> {
  ClearRecentSearchesUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) =>
      repository.clearRecentSearches();
}
