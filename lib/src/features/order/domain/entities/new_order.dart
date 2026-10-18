import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/features/order/domain/entities/order_entity.dart';

/// Everything checkout knows when the user taps Place order.
class NewOrder extends Equatable {
  final List<OrderItem> items;
  final ShipTo shipTo;
  final String shippingMethod;
  final double shippingFee;
  final int deliveryDays;
  final String paymentMethod;
  final double subtotal;
  final double discount;
  final double total;
  final String? voucherCode;

  const NewOrder({
    required this.items,
    required this.shipTo,
    required this.shippingMethod,
    required this.shippingFee,
    required this.deliveryDays,
    required this.paymentMethod,
    required this.subtotal,
    required this.discount,
    required this.total,
    this.voucherCode,
  });

  @override
  List<Object?> get props => [
    items,
    shipTo,
    shippingMethod,
    shippingFee,
    deliveryDays,
    paymentMethod,
    subtotal,
    discount,
    total,
    voucherCode,
  ];
}
