import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/data/models/address_model.dart';
import 'package:tuku_shop/src/features/checkout/data/models/delivery_option_model.dart';
import 'package:tuku_shop/src/features/checkout/data/models/payment_method_model.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

class AddressModelToAddressEntityMapper {
  const AddressModelToAddressEntityMapper._();

  static AddressEntity toEntity(AddressModel model) => AddressEntity(
    id: model.id ?? '',
    label: model.label ?? '',
    fullName: model.fullName ?? '',
    phone: model.phone ?? '',
    street: model.street ?? '',
    city: model.city ?? '',
    postalCode: model.postalCode ?? '',
    country: model.country ?? '',
    isDefault: model.isDefault ?? false,
  );

  static AddressModel toModel(AddressEntity entity) => AddressModel(
    id: entity.id,
    label: entity.label,
    fullName: entity.fullName,
    phone: entity.phone,
    street: entity.street,
    city: entity.city,
    postalCode: entity.postalCode,
    country: entity.country,
    isDefault: entity.isDefault,
  );
}

class PaymentMethodModelToPaymentMethodEntityMapper {
  const PaymentMethodModelToPaymentMethodEntityMapper._();

  static PaymentMethodEntity toEntity(PaymentMethodModel model) =>
      PaymentMethodEntity(
        id: model.id ?? '',
        type: PaymentMethodType.fromName(model.type),
        label: model.label ?? '',
        detail: model.detail,
        isDefault: model.isDefault ?? false,
      );
}

class DeliveryOptionModelToDeliveryOptionEntityMapper {
  const DeliveryOptionModelToDeliveryOptionEntityMapper._();

  static DeliveryOptionEntity toEntity(DeliveryOptionModel model) =>
      DeliveryOptionEntity(
        id: model.id ?? '',
        minDays: model.minDays ?? 0,
        maxDays: model.maxDays ?? 0,
        fee: model.fee ?? 0,
        freeOverThreshold: model.freeOverThreshold ?? false,
      );
}
