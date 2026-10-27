import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class GetProductsUsecase implements UseCase<ProductsData, ProductQuery> {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  @override
  Future<Either<Failure, ProductsData>> call(ProductQuery params) {
    return repository.getProducts(params);
  }
}
