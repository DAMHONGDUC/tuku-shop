import 'package:equatable/equatable.dart';

class ShippingMethod extends Equatable {
  final String id;
  final String name;
  final int minDays;
  final int maxDays;
  final double fee;

  /// Ships free at or above this subtotal; null for never.
  final double? freeOver;

  const ShippingMethod({
    required this.id,
    required this.name,
    required this.minDays,
    required this.maxDays,
    required this.fee,
    this.freeOver,
  });

  double feeFor(double subtotal) =>
      freeOver != null && subtotal >= freeOver! ? 0 : fee;

  @override
  List<Object?> get props => [id, name, minDays, maxDays, fee, freeOver];
}

enum PaymentType { cashOnDelivery, card, wallet }

class PaymentMethod extends Equatable {
  final String id;
  final String name;
  final PaymentType type;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, type];
}

class Voucher extends Equatable {
  final String code;
  final int percentOff;
  final bool freeShipping;

  const Voucher({
    required this.code,
    this.percentOff = 0,
    this.freeShipping = false,
  });

  @override
  List<Object?> get props => [code, percentOff, freeShipping];
}

/// The money math for an order, in one place.
class CheckoutTotals extends Equatable {
  final double subtotal;
  final double shippingFee;
  final double discount;

  const CheckoutTotals({
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
  });

  factory CheckoutTotals.compute({
    required double subtotal,
    ShippingMethod? shipping,
    Voucher? voucher,
  }) {
    final rawFee = shipping?.feeFor(subtotal) ?? 0;
    final fee = voucher?.freeShipping == true && shipping?.id == 'standard'
        ? 0.0
        : rawFee;
    final discount = _round(subtotal * (voucher?.percentOff ?? 0) / 100);
    return CheckoutTotals(
      subtotal: subtotal,
      shippingFee: fee,
      discount: discount,
    );
  }

  static double _round(double v) => (v * 100).roundToDouble() / 100;

  double get total => _round(subtotal - discount + shippingFee);

  @override
  List<Object?> get props => [subtotal, shippingFee, discount];
}
