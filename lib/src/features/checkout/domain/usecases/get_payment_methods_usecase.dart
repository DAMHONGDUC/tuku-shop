import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/payment_method_entity.dart';
import '../repositories/checkout_repository.dart';

class GetPaymentMethodsUsecase
    implements UseCase<List<PaymentMethodEntity>, NoParams> {
  GetPaymentMethodsUsecase(this.repository);

  final CheckoutRepository repository;

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> call(NoParams params) =>
      repository.getPaymentMethods();
}
