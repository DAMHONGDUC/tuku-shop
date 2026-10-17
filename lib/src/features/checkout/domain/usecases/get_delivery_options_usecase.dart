import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/delivery_option_entity.dart';
import '../repositories/checkout_repository.dart';

class GetDeliveryOptionsUsecase
    implements UseCase<List<DeliveryOptionEntity>, NoParams> {
  GetDeliveryOptionsUsecase(this.repository);

  final CheckoutRepository repository;

  @override
  Future<Either<Failure, List<DeliveryOptionEntity>>> call(NoParams params) =>
      repository.getDeliveryOptions();
}
