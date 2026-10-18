import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/features/checkout/data/mock/checkout_mock.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

void main() {
  final standard = CheckoutMock.shippingMethods.first;
  final express = CheckoutMock.shippingMethods.last;
  const tuku10 = Voucher(code: 'TUKU10', percentOff: 10);
  const freeShip = Voucher(code: 'FREESHIP', freeShipping: true);

  test('standard shipping costs 4.99 under 100 and is free from 100', () {
    expect(
      CheckoutTotals.compute(subtotal: 99.99, shipping: standard).total,
      104.98,
    );
    expect(
      CheckoutTotals.compute(subtotal: 100, shipping: standard).shippingFee,
      0,
    );
  });

  test('express always charges', () {
    expect(
      CheckoutTotals.compute(subtotal: 300, shipping: express).shippingFee,
      12.99,
    );
  });

  test('TUKU10 takes 10 % off the subtotal, rounded to cents', () {
    final t = CheckoutTotals.compute(
      subtotal: 128,
      shipping: standard,
      voucher: tuku10,
    );
    expect(t.discount, 12.8);
    expect(t.total, 115.2);
  });

  test('FREESHIP removes the standard fee but not express', () {
    expect(
      CheckoutTotals.compute(
        subtotal: 40,
        shipping: standard,
        voucher: freeShip,
      ).shippingFee,
      0,
    );
    expect(
      CheckoutTotals.compute(
        subtotal: 40,
        shipping: express,
        voucher: freeShip,
      ).shippingFee,
      12.99,
    );
  });
}
