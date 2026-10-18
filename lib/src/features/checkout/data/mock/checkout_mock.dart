import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

class CheckoutMock {
  static const shippingMethods = [
    ShippingMethod(
      id: 'standard',
      name: 'Standard',
      minDays: 3,
      maxDays: 5,
      fee: 4.99,
      freeOver: 100,
    ),
    ShippingMethod(
      id: 'express',
      name: 'Express',
      minDays: 1,
      maxDays: 2,
      fee: 12.99,
    ),
  ];

  static const paymentMethods = [
    PaymentMethod(
      id: 'cod',
      name: 'Cash on delivery',
      type: PaymentType.cashOnDelivery,
    ),
    PaymentMethod(id: 'card', name: 'Card (demo)', type: PaymentType.card),
    PaymentMethod(
      id: 'wallet',
      name: 'E-wallet (demo)',
      type: PaymentType.wallet,
    ),
  ];

  static const vouchers = [
    Voucher(code: 'TUKU10', percentOff: 10),
    Voucher(code: 'FREESHIP', freeShipping: true),
  ];
}
