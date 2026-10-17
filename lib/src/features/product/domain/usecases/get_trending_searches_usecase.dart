import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/product_repository.dart';

class GetTrendingSearchesUsecase implements UseCase<List<String>, NoParams> {
  GetTrendingSearchesUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) =>
      repository.getTrendingSearches();
}
