import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/domain/entities/checkout_options.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, List<ShippingMethod>>> getShippingMethods();

  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods();

  /// `ValidationFailure('invalid_voucher')` for an unknown code.
  Future<Either<Failure, Voucher>> applyVoucher(String code);
}
