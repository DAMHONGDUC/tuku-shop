import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  const AddressEntity({
    required this.id,
    required this.label,
    required this.fullName,
    required this.phone,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.country,
    this.isDefault = false,
  });

  final String id;

  /// "Home", "Office" — the user's own word for it.
  final String label;
  final String fullName;
  final String phone;
  final String street;
  final String city;
  final String postalCode;
  final String country;
  final bool isDefault;

  /// One line, the way a label prints it.
  String get oneLine => '$street, $city $postalCode, $country';

  AddressEntity copyWith({String? id, bool? isDefault}) => AddressEntity(
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

  @override
  List<Object> get props => <Object>[
    id,
    label,
    fullName,
    phone,
    street,
    city,
    postalCode,
    country,
    isDefault,
  ];
}
