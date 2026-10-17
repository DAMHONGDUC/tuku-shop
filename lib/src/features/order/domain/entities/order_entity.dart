import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import 'order_item_entity.dart';
import 'tracking_event_entity.dart';

/// A placed order. It keeps its own copy of the address and payment as they
/// were at checkout — editing the address book later must not rewrite where
/// a past order went.
class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.code,
    required this.createdAt,
    required this.status,
    required this.items,
    required this.recipient,
    required this.phone,
    required this.address,
    required this.paymentType,
    required this.paymentLabel,
    required this.deliveryOptionId,
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
    required this.estimatedDelivery,
    required this.tracking,
    this.promoCode,
  });

  final String id;

  /// What the customer quotes to support — `TK-240917`.
  final String code;
  final DateTime createdAt;
  final OrderStatus status;
  final List<OrderItemEntity> items;
  final String recipient;
  final String phone;
  final String address;
  final PaymentMethodType paymentType;
  final String paymentLabel;
  final String deliveryOptionId;
  final double subtotal;
  final double shippingFee;
  final double discount;
  final String? promoCode;
  final DateTime estimatedDelivery;

  /// Oldest first.
  final List<TrackingEventEntity> tracking;

  int get itemCount => items.map((OrderItemEntity i) => i.quantity).sum;

  double get total => subtotal - discount + shippingFee;

  @override
  List<Object?> get props => <Object?>[
    id,
    code,
    createdAt,
    status,
    items,
    recipient,
    phone,
    address,
    paymentType,
    paymentLabel,
    deliveryOptionId,
    subtotal,
    shippingFee,
    discount,
    promoCode,
    estimatedDelivery,
    tracking,
  ];
}
