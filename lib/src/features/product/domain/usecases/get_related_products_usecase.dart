import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetRelatedProductsUsecase
    implements UseCase<List<ProductEntity>, String> {
  GetRelatedProductsUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(String params) =>
      repository.getRelatedProducts(params);
}
