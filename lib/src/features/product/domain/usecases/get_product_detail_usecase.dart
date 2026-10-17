import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductDetailUsecase implements UseCase<ProductEntity, String> {
  GetProductDetailUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, ProductEntity>> call(String params) =>
      repository.getProductDetail(params);
}
