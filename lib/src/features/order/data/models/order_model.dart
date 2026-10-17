class OrderItemModel {
  const OrderItemModel({
    this.productId,
    this.name,
    this.image,
    this.color,
    this.size,
    this.quantity,
    this.unitPrice,
  });

  final String? productId;
  final String? name;
  final String? image;
  final String? color;
  final String? size;
  final int? quantity;
  final double? unitPrice;
}

class TrackingEventModel {
  const TrackingEventModel({this.status, this.time, this.location});

  final String? status;
  final DateTime? time;
  final String? location;
}

class OrderModel {
  const OrderModel({
    this.id,
    this.code,
    this.createdAt,
    this.status,
    this.items,
    this.recipient,
    this.phone,
    this.address,
    this.paymentType,
    this.paymentLabel,
    this.deliveryOptionId,
    this.subtotal,
    this.shippingFee,
    this.discount,
    this.promoCode,
    this.estimatedDelivery,
    this.tracking,
  });

  final String? id;
  final String? code;
  final DateTime? createdAt;
  final String? status;
  final List<OrderItemModel>? items;
  final String? recipient;
  final String? phone;
  final String? address;
  final String? paymentType;
  final String? paymentLabel;
  final String? deliveryOptionId;
  final double? subtotal;
  final double? shippingFee;
  final double? discount;
  final String? promoCode;
  final DateTime? estimatedDelivery;
  final List<TrackingEventModel>? tracking;

  OrderModel copyWith({String? status, List<TrackingEventModel>? tracking}) =>
      OrderModel(
        id: id,
        code: code,
        createdAt: createdAt,
        status: status ?? this.status,
        items: items,
        recipient: recipient,
        phone: phone,
        address: address,
        paymentType: paymentType,
        paymentLabel: paymentLabel,
        deliveryOptionId: deliveryOptionId,
        subtotal: subtotal,
        shippingFee: shippingFee,
        discount: discount,
        promoCode: promoCode,
        estimatedDelivery: estimatedDelivery,
        tracking: tracking ?? this.tracking,
      );
}
