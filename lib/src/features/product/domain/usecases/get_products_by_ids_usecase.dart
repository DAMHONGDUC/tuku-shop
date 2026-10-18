import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// Products in the order of [ids]; unknown ids are skipped.
class GetProductsByIdsUsecase
    implements UseCase<List<ProductEntity>, List<String>> {
  final ProductRepository repository;

  GetProductsByIdsUsecase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(List<String> params) {
    if (params.isEmpty) return Future.value(const Right([]));
    return repository.getProductsByIds(params);
  }
}
