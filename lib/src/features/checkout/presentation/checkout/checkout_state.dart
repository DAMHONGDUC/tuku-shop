part of 'checkout_controller.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    this.status = LoadStatus.loading,
    this.addresses = const <AddressEntity>[],
    this.payments = const <PaymentMethodEntity>[],
    this.deliveryOptions = const <DeliveryOptionEntity>[],
    this.addressId,
    this.paymentId,
    this.deliveryId,
    this.placing = false,
    this.placedOrderId,
    this.failure,
  });

  final LoadStatus status;
  final List<AddressEntity> addresses;
  final List<PaymentMethodEntity> payments;
  final List<DeliveryOptionEntity> deliveryOptions;
  final String? addressId;
  final String? paymentId;
  final String? deliveryId;
  final bool placing;
  final String? placedOrderId;
  final Failure? failure;

  AddressEntity? get address =>
      addresses.firstWhereOrNull((AddressEntity a) => a.id == addressId);

  PaymentMethodEntity? get payment =>
      payments.firstWhereOrNull((PaymentMethodEntity p) => p.id == paymentId);

  DeliveryOptionEntity? get delivery => deliveryOptions.firstWhereOrNull(
    (DeliveryOptionEntity d) => d.id == deliveryId,
  );

  bool get canPlace => address != null && payment != null && delivery != null;

  CheckoutState copyWith({
    List<AddressEntity>? addresses,
    String? addressId,
    String? paymentId,
    String? deliveryId,
    bool? placing,
    String? placedOrderId,
    Failure? Function()? failure,
  }) => CheckoutState(
    status: status,
    addresses: addresses ?? this.addresses,
    payments: payments,
    deliveryOptions: deliveryOptions,
    addressId: addressId ?? this.addressId,
    paymentId: paymentId ?? this.paymentId,
    deliveryId: deliveryId ?? this.deliveryId,
    placing: placing ?? this.placing,
    placedOrderId: placedOrderId ?? this.placedOrderId,
    failure: failure == null ? this.failure : failure(),
  );

  @override
  List<Object?> get props => <Object?>[
    status,
    addresses,
    payments,
    deliveryOptions,
    addressId,
    paymentId,
    deliveryId,
    placing,
    placedOrderId,
    failure,
  ];
}
