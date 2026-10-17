import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/address_entity.dart';
import '../entities/delivery_option_entity.dart';
import '../entities/payment_method_entity.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();

  /// Adds [address] when its id is empty, replaces it otherwise.
  Future<Either<Failure, AddressEntity>> saveAddress(AddressEntity address);

  Future<Either<Failure, Unit>> deleteAddress(String id);

  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods();

  Future<Either<Failure, List<PaymentMethodEntity>>> setDefaultPaymentMethod(
    String id,
  );

  Future<Either<Failure, List<DeliveryOptionEntity>>> getDeliveryOptions();
}
