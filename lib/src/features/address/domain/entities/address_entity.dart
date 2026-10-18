import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;

  /// Home, Office… shown as a chip.
  final String label;
  final String fullName;
  final String phone;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final bool isDefault;

  const AddressEntity({
    required this.id,
    required this.label,
    required this.fullName,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    this.isDefault = false,
  });

  /// One line for lists and order snapshots.
  String get singleLine => '$street, $city, $state $postalCode';

  AddressEntity copyWith({String? id, bool? isDefault}) => AddressEntity(
    id: id ?? this.id,
    label: label,
    fullName: fullName,
    phone: phone,
    street: street,
    city: city,
    state: state,
    postalCode: postalCode,
    isDefault: isDefault ?? this.isDefault,
  );

  @override
  List<Object?> get props => [
    id,
    label,
    fullName,
    phone,
    street,
    city,
    state,
    postalCode,
    isDefault,
  ];
}
