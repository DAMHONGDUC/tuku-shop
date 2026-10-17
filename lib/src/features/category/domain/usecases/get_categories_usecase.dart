import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUsecase implements UseCase<List<CategoryEntity>, NoParams> {
  GetCategoriesUsecase(this.repository);

  final CategoryRepository repository;

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) =>
      repository.getCategories();
}
