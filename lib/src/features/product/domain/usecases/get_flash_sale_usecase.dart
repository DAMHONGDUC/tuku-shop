import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/flash_sale_entity.dart';
import '../repositories/product_repository.dart';

class GetFlashSaleUsecase implements UseCase<FlashSaleEntity, NoParams> {
  GetFlashSaleUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, FlashSaleEntity>> call(NoParams params) =>
      repository.getFlashSale();
}
