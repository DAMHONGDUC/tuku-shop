import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/address_entity.dart';
import '../repositories/checkout_repository.dart';

class GetAddressesUsecase implements UseCase<List<AddressEntity>, NoParams> {
  GetAddressesUsecase(this.repository);

  final CheckoutRepository repository;

  @override
  Future<Either<Failure, List<AddressEntity>>> call(NoParams params) =>
      repository.getAddresses();
}
