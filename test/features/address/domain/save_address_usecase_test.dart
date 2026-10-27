import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';

void main() {
  const valid = AddressEntity(
    id: '',
    label: 'Home',
    fullName: 'Tuku Demo',
    phone: '+1 202 555 0147',
    street: '1600 Market St',
    city: 'San Francisco',
    state: 'CA',
    postalCode: '94103',
  );

  test('a complete address has no errors', () {
    expect(SaveAddressUsecase.validate(valid), isEmpty);
  });

  test('flags each wrong field', () {
    const bad = AddressEntity(
      id: '',
      label: 'Home',
      fullName: 'T',
      phone: 'abc',
      street: '1',
      city: '',
      state: '',
      postalCode: '!',
    );
    expect(SaveAddressUsecase.validate(bad), AddressField.values.toSet());
  });
}
