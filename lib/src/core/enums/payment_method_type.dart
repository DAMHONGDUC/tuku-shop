enum PaymentMethodType {
  card,
  applePay,
  paypal,
  cashOnDelivery;

  static PaymentMethodType fromName(String? value) =>
      PaymentMethodType.values.firstWhere(
        (PaymentMethodType e) => e.name == value,
        orElse: () => PaymentMethodType.card,
      );
}
