import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/domain/entities/checkout_options.dart';
import 'package:tuku_shop/src/features/checkout/domain/repositories/checkout_repository.dart';

class GetShippingMethodsUsecase
    implements UseCase<List<ShippingMethod>, NoParams> {
  final CheckoutRepository repository;

  GetShippingMethodsUsecase(this.repository);

  @override
  Future<Either<Failure, List<ShippingMethod>>> call(NoParams params) =>
      repository.getShippingMethods();
}

class GetPaymentMethodsUsecase
    implements UseCase<List<PaymentMethod>, NoParams> {
  final CheckoutRepository repository;

  GetPaymentMethodsUsecase(this.repository);

  @override
  Future<Either<Failure, List<PaymentMethod>>> call(NoParams params) =>
      repository.getPaymentMethods();
}

class ApplyVoucherUsecase implements UseCase<Voucher, String> {
  final CheckoutRepository repository;

  ApplyVoucherUsecase(this.repository);

  @override
  Future<Either<Failure, Voucher>> call(String params) {
    final code = params.trim().toUpperCase();
    if (code.isEmpty) {
      return Future.value(const Left(ValidationFailure('invalid_voucher')));
    }
    return repository.applyVoucher(code);
  }
}
