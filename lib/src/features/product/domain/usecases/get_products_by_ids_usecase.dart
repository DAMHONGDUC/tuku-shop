import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsByIdsUsecase
    implements UseCase<List<ProductEntity>, List<String>> {
  GetProductsByIdsUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(List<String> params) =>
      repository.getProductsByIds(params);
}
