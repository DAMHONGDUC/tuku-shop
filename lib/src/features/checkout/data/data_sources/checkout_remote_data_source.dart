import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/data/mock/checkout_mock.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

abstract class CheckoutRemoteDataSource {
  Future<List<ShippingMethod>> getShippingMethods();

  Future<List<PaymentMethod>> getPaymentMethods();

  /// Throws [ValidationException] for an unknown code.
  Future<Voucher> applyVoucher(String code);
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  const CheckoutRemoteDataSourceImpl();

  @override
  Future<List<ShippingMethod>> getShippingMethods() async {
    await MockLatency.wait();
    return CheckoutMock.shippingMethods;
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    await MockLatency.wait();
    return CheckoutMock.paymentMethods;
  }

  @override
  Future<Voucher> applyVoucher(String code) async {
    await MockLatency.wait();
    final voucher = CheckoutMock.vouchers.firstWhereOrNull(
      (v) => v.code == code,
    );
    if (voucher == null) throw const ValidationException('invalid_voucher');
    return voucher;
  }
}
