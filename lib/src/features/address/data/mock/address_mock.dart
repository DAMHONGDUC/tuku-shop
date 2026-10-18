import 'package:tuku_shop/src/features/address/data/models/address_model.dart';

class AddressMock {
  static const seed = [
    AddressModel(
      id: 'addr-home',
      label: 'Home',
      fullName: 'Tuku Demo',
      phone: '+1 202 555 0147',
      street: '1600 Market St, Apt 12',
      city: 'San Francisco',
      state: 'CA',
      postalCode: '94103',
      isDefault: true,
    ),
    AddressModel(
      id: 'addr-office',
      label: 'Office',
      fullName: 'Tuku Demo',
      phone: '+1 202 555 0188',
      street: '500 Howard St, Floor 4',
      city: 'San Francisco',
      state: 'CA',
      postalCode: '94105',
      isDefault: false,
    ),
  ];
}
