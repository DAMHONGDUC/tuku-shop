class PaymentMethodModel {
  const PaymentMethodModel({
    this.id,
    this.type,
    this.label,
    this.detail,
    this.isDefault,
  });

  final String? id;
  final String? type;
  final String? label;
  final String? detail;
  final bool? isDefault;

  PaymentMethodModel copyWith({bool? isDefault}) => PaymentMethodModel(
    id: id,
    type: type,
    label: label,
    detail: detail,
    isDefault: isDefault ?? this.isDefault,
  );
}
