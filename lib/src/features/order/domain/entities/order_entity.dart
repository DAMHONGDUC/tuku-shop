import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

class OrderItem extends Equatable {
  final String productId;
  final String name;
  final String imageUrl;
  final String colorName;
  final String size;
  final double unitPrice;
  final int quantity;

  const OrderItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.colorName,
    required this.size,
    required this.unitPrice,
    required this.quantity,
  });

  double get total => unitPrice * quantity;

  @override
  List<Object?> get props => [
    productId,
    name,
    imageUrl,
    colorName,
    size,
    unitPrice,
    quantity,
  ];
}

/// Where the order goes, copied from the address book when it was placed.
class ShipTo extends Equatable {
  final String fullName;
  final String phone;
  final String address;

  const ShipTo({
    required this.fullName,
    required this.phone,
    required this.address,
  });

  @override
  List<Object?> get props => [fullName, phone, address];
}

class OrderEvent extends Equatable {
  final OrderStatus status;
  final DateTime at;

  const OrderEvent({required this.status, required this.at});

  @override
  List<Object?> get props => [status, at];
}

class OrderEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final OrderStatus status;
  final List<OrderItem> items;
  final ShipTo shipTo;
  final String shippingMethod;
  final double shippingFee;
  final String paymentMethod;
  final double subtotal;
  final double discount;
  final double total;
  final String? voucherCode;
  final DateTime estimatedDelivery;

  /// Status changes so far, oldest first.
  final List<OrderEvent> events;

  const OrderEntity({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.items,
    required this.shipTo,
    required this.shippingMethod,
    required this.shippingFee,
    required this.paymentMethod,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.estimatedDelivery,
    required this.events,
    this.voucherCode,
  });

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);

  /// Only an order nobody has confirmed yet can be cancelled.
  bool get canCancel => status == OrderStatus.waitingForConfirmation;

  @override
  List<Object?> get props => [
    id,
    createdAt,
    status,
    items,
    shipTo,
    shippingMethod,
    shippingFee,
    paymentMethod,
    subtotal,
    discount,
    total,
    voucherCode,
    estimatedDelivery,
    events,
  ];
}
