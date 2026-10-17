import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/checkout_repository.dart';

class DeleteAddressUsecase implements UseCase<Unit, String> {
  DeleteAddressUsecase(this.repository);

  final CheckoutRepository repository;

  @override
  Future<Either<Failure, Unit>> call(String params) =>
      repository.deleteAddress(params);
}
