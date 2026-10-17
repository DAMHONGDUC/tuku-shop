import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/address_entity.dart';
import '../repositories/checkout_repository.dart';

class SaveAddressUsecase implements UseCase<AddressEntity, AddressEntity> {
  SaveAddressUsecase(this.repository);

  final CheckoutRepository repository;

  @override
  Future<Either<Failure, AddressEntity>> call(AddressEntity params) =>
      repository.saveAddress(params);
}
