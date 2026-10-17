import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/data/mock/checkout_mock.dart';
import 'package:tuku_shop/src/features/checkout/data/models/address_model.dart';
import 'package:tuku_shop/src/features/checkout/data/models/delivery_option_model.dart';
import 'package:tuku_shop/src/features/checkout/data/models/payment_method_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<List<AddressModel>> getAddresses();

  Future<AddressModel> saveAddress(AddressModel address);

  Future<void> deleteAddress(String id);

  Future<List<PaymentMethodModel>> getPaymentMethods();

  Future<List<PaymentMethodModel>> setDefaultPaymentMethod(String id);

  Future<List<DeliveryOptionModel>> getDeliveryOptions();
}

/// The account's address book and wallet, held for the session.
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final List<AddressModel> _addresses = List<AddressModel>.of(
    CheckoutMock.addresses,
  );
  List<PaymentMethodModel> _payments = List<PaymentMethodModel>.of(
    CheckoutMock.paymentMethods,
  );

  @override
  Future<List<AddressModel>> getAddresses() async {
    await MockLatency.short();
    return List<AddressModel>.unmodifiable(_addresses);
  }

  @override
  Future<AddressModel> saveAddress(AddressModel address) async {
    await MockLatency.normal();

    final bool isNew = (address.id ?? '').isEmpty;
    final AddressModel saved = isNew
        ? address.copyWith(
            id: SdId.unique(),
            isDefault: address.isDefault == true || _addresses.isEmpty,
          )
        : address;

    if (saved.isDefault == true) {
      for (int i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(isDefault: false);
      }
    }

    final int index = _addresses.indexWhere(
      (AddressModel a) => a.id == saved.id,
    );

    if (index >= 0) {
      _addresses[index] = saved;
    } else {
      _addresses.add(saved);
    }

    return saved;
  }

  @override
  Future<void> deleteAddress(String id) async {
    await MockLatency.short();

    final bool wasDefault = _addresses.any(
      (AddressModel a) => a.id == id && a.isDefault == true,
    );
    _addresses.removeWhere((AddressModel a) => a.id == id);

    if (wasDefault && _addresses.isNotEmpty) {
      _addresses[0] = _addresses[0].copyWith(isDefault: true);
    }
  }

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    await MockLatency.short();
    return List<PaymentMethodModel>.unmodifiable(_payments);
  }

  @override
  Future<List<PaymentMethodModel>> setDefaultPaymentMethod(String id) async {
    await MockLatency.short();

    _payments = _payments
        .map((PaymentMethodModel p) => p.copyWith(isDefault: p.id == id))
        .toList();
    return List<PaymentMethodModel>.unmodifiable(_payments);
  }

  @override
  Future<List<DeliveryOptionModel>> getDeliveryOptions() async {
    await MockLatency.short();
    return CheckoutMock.deliveryOptions;
  }
}
