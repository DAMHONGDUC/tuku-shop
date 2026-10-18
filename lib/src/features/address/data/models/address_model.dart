class AddressModel {
  final String? id;
  final String? label;
  final String? fullName;
  final String? phone;
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final bool? isDefault;

  const AddressModel({
    this.id,
    this.label,
    this.fullName,
    this.phone,
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> j) => AddressModel(
    id: j['id'] as String?,
    label: j['label'] as String?,
    fullName: j['fullName'] as String?,
    phone: j['phone'] as String?,
    street: j['street'] as String?,
    city: j['city'] as String?,
    state: j['state'] as String?,
    postalCode: j['postalCode'] as String?,
    isDefault: j['isDefault'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'fullName': fullName,
    'phone': phone,
    'street': street,
    'city': city,
    'state': state,
    'postalCode': postalCode,
    'isDefault': isDefault,
  };
}
