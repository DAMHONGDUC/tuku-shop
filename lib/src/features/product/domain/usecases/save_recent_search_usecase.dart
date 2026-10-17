import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/product_repository.dart';

class SaveRecentSearchUsecase implements UseCase<List<String>, String> {
  SaveRecentSearchUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<String>>> call(String params) =>
      repository.saveRecentSearch(params.trim());
}
