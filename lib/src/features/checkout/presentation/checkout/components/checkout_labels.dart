import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

/// Names and glyphs for delivery options and payment types.
extension CheckoutLabels on BuildContext {
  String deliveryName(String id) => switch (id) {
    'express' => loc.delivery_express,
    'nextDay' => loc.delivery_next_day,
    _ => loc.delivery_standard,
  };

  String deliveryEta(DeliveryOptionEntity option) {
    final DateTime now = DateTime.now();
    final String from = Formatters.date(now.add(Duration(days: option.minDays)), localeName);
    final String to = Formatters.date(now.add(Duration(days: option.maxDays)), localeName);

    return option.minDays == option.maxDays
        ? loc.delivery_eta_single(from)
        : loc.delivery_eta_range(from, to);
  }

  String paymentName(PaymentMethodEntity method) => switch (method.type) {
    PaymentMethodType.cashOnDelivery => loc.payment_cod,
    _ => method.label,
  };
}

IconData paymentIcon(PaymentMethodType type) => switch (type) {
  PaymentMethodType.card => Symbols.credit_card_rounded,
  PaymentMethodType.applePay => Symbols.phone_iphone_rounded,
  PaymentMethodType.paypal => Symbols.account_balance_wallet_rounded,
  PaymentMethodType.cashOnDelivery => Symbols.payments_rounded,
};
