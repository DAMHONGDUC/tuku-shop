import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/product_page.dart';
import '../entities/product_query.dart';
import '../repositories/product_repository.dart';

class GetProductsUsecase implements UseCase<ProductPage, ProductQuery> {
  GetProductsUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, ProductPage>> call(ProductQuery params) =>
      repository.getProducts(params);
}
