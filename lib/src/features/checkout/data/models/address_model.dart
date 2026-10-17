class AddressModel {
  const AddressModel({
    this.id,
    this.label,
    this.fullName,
    this.phone,
    this.street,
    this.city,
    this.postalCode,
    this.country,
    this.isDefault,
  });

  final String? id;
  final String? label;
  final String? fullName;
  final String? phone;
  final String? street;
  final String? city;
  final String? postalCode;
  final String? country;
  final bool? isDefault;

  AddressModel copyWith({String? id, bool? isDefault}) => AddressModel(
    id: id ?? this.id,
    label: label,
    fullName: fullName,
    phone: phone,
    street: street,
    city: city,
    postalCode: postalCode,
    country: country,
    isDefault: isDefault ?? this.isDefault,
  );
}
