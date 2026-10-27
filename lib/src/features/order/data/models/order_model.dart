/// An order as the order service stores it (JSON on the device for the demo).
class OrderModel {
  final String? id;
  final String? createdAt;
  final String? status;
  final List<OrderItemModel>? items;
  final String? shipToName;
  final String? shipToPhone;
  final String? shipToAddress;
  final String? shippingMethod;
  final double? shippingFee;
  final String? paymentMethod;
  final double? subtotal;
  final double? discount;
  final double? total;
  final String? voucherCode;
  final String? estimatedDelivery;
  final List<OrderEventModel>? events;

  const OrderModel({
    this.id,
    this.createdAt,
    this.status,
    this.items,
    this.shipToName,
    this.shipToPhone,
    this.shipToAddress,
    this.shippingMethod,
    this.shippingFee,
    this.paymentMethod,
    this.subtotal,
    this.discount,
    this.total,
    this.voucherCode,
    this.estimatedDelivery,
    this.events,
  });

  OrderModel copyWith({
    String? id,
    String? status,
    List<OrderEventModel>? events,
  }) => OrderModel(
    id: id ?? this.id,
    createdAt: createdAt,
    status: status ?? this.status,
    items: items,
    shipToName: shipToName,
    shipToPhone: shipToPhone,
    shipToAddress: shipToAddress,
    shippingMethod: shippingMethod,
    shippingFee: shippingFee,
    paymentMethod: paymentMethod,
    subtotal: subtotal,
    discount: discount,
    total: total,
    voucherCode: voucherCode,
    estimatedDelivery: estimatedDelivery,
    events: events ?? this.events,
  );

  factory OrderModel.fromJson(Map<String, dynamic> j) => OrderModel(
    id: j['id'] as String?,
    createdAt: j['createdAt'] as String?,
    status: j['status'] as String?,
    items: (j['items'] as List?)
        ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    shipToName: j['shipToName'] as String?,
    shipToPhone: j['shipToPhone'] as String?,
    shipToAddress: j['shipToAddress'] as String?,
    shippingMethod: j['shippingMethod'] as String?,
    shippingFee: (j['shippingFee'] as num?)?.toDouble(),
    paymentMethod: j['paymentMethod'] as String?,
    subtotal: (j['subtotal'] as num?)?.toDouble(),
    discount: (j['discount'] as num?)?.toDouble(),
    total: (j['total'] as num?)?.toDouble(),
    voucherCode: j['voucherCode'] as String?,
    estimatedDelivery: j['estimatedDelivery'] as String?,
    events: (j['events'] as List?)
        ?.map((e) => OrderEventModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'status': status,
    'items': items?.map((e) => e.toJson()).toList(),
    'shipToName': shipToName,
    'shipToPhone': shipToPhone,
    'shipToAddress': shipToAddress,
    'shippingMethod': shippingMethod,
    'shippingFee': shippingFee,
    'paymentMethod': paymentMethod,
    'subtotal': subtotal,
    'discount': discount,
    'total': total,
    'voucherCode': voucherCode,
    'estimatedDelivery': estimatedDelivery,
    'events': events?.map((e) => e.toJson()).toList(),
  };
}

class OrderItemModel {
  final String? productId;
  final String? name;
  final String? imageUrl;
  final String? colorName;
  final String? size;
  final double? unitPrice;
  final int? quantity;

  const OrderItemModel({
    this.productId,
    this.name,
    this.imageUrl,
    this.colorName,
    this.size,
    this.unitPrice,
    this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> j) => OrderItemModel(
    productId: j['productId'] as String?,
    name: j['name'] as String?,
    imageUrl: j['imageUrl'] as String?,
    colorName: j['colorName'] as String?,
    size: j['size'] as String?,
    unitPrice: (j['unitPrice'] as num?)?.toDouble(),
    quantity: j['quantity'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'imageUrl': imageUrl,
    'colorName': colorName,
    'size': size,
    'unitPrice': unitPrice,
    'quantity': quantity,
  };
}

class OrderEventModel {
  final String? status;
  final String? at;

  const OrderEventModel({this.status, this.at});

  factory OrderEventModel.fromJson(Map<String, dynamic> j) =>
      OrderEventModel(status: j['status'] as String?, at: j['at'] as String?);

  Map<String, dynamic> toJson() => {'status': status, 'at': at};
}
