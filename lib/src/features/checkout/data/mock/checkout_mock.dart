import 'package:tuku_shop/src/features/checkout/data/models/address_model.dart';
import 'package:tuku_shop/src/features/checkout/data/models/delivery_option_model.dart';
import 'package:tuku_shop/src/features/checkout/data/models/payment_method_model.dart';

abstract final class CheckoutMock {
  static const List<AddressModel> addresses = <AddressModel>[
    AddressModel(
      id: 'addr_home',
      label: 'Home',
      fullName: 'Alex Morgan',
      phone: '+1 (415) 555-0132',
      street: '742 Valencia Street, Apt 3B',
      city: 'San Francisco, CA',
      postalCode: '94110',
      country: 'United States',
      isDefault: true,
    ),
    AddressModel(
      id: 'addr_office',
      label: 'Office',
      fullName: 'Alex Morgan',
      phone: '+1 (415) 555-0178',
      street: '500 Howard Street, Floor 9',
      city: 'San Francisco, CA',
      postalCode: '94105',
      country: 'United States',
    ),
  ];

  static const List<PaymentMethodModel> paymentMethods = <PaymentMethodModel>[
    PaymentMethodModel(
      id: 'pm_visa',
      type: 'card',
      label: 'Visa',
      detail: '•••• 4242 · 08/28',
      isDefault: true,
    ),
    PaymentMethodModel(
      id: 'pm_master',
      type: 'card',
      label: 'Mastercard',
      detail: '•••• 5100 · 11/27',
    ),
    PaymentMethodModel(id: 'pm_apple', type: 'applePay', label: 'Apple Pay'),
    PaymentMethodModel(
      id: 'pm_paypal',
      type: 'paypal',
      label: 'PayPal',
      detail: 'alex.morgan@mail.com',
    ),
    PaymentMethodModel(id: 'pm_cod', type: 'cashOnDelivery', label: 'Cash'),
  ];

  static const List<DeliveryOptionModel> deliveryOptions =
      <DeliveryOptionModel>[
        DeliveryOptionModel(
          id: 'standard',
          minDays: 3,
          maxDays: 5,
          fee: 6.99,
          freeOverThreshold: true,
        ),
        DeliveryOptionModel(id: 'express', minDays: 1, maxDays: 2, fee: 14.99),
        DeliveryOptionModel(id: 'nextDay', minDays: 1, maxDays: 1, fee: 24.99),
      ];
}
