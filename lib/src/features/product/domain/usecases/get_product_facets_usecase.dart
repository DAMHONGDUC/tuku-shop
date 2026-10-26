import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class GetProductFacetsUsecase implements UseCase<ProductFacets, NoParams> {
  final ProductRepository repository;

  GetProductFacetsUsecase(this.repository);

  @override
  Future<Either<Failure, ProductFacets>> call(NoParams params) =>
      repository.getFacets();
}
