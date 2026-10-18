class CartLineModel {
  final String? productId;
  final String? name;
  final String? brand;
  final String? imageUrl;
  final String? colorName;
  final String? size;
  final double? unitPrice;
  final double? originalPrice;
  final int? quantity;
  final int? maxQuantity;

  const CartLineModel({
    this.productId,
    this.name,
    this.brand,
    this.imageUrl,
    this.colorName,
    this.size,
    this.unitPrice,
    this.originalPrice,
    this.quantity,
    this.maxQuantity,
  });

  factory CartLineModel.fromJson(Map<String, dynamic> json) => CartLineModel(
    productId: json['productId'] as String?,
    name: json['name'] as String?,
    brand: json['brand'] as String?,
    imageUrl: json['imageUrl'] as String?,
    colorName: json['colorName'] as String?,
    size: json['size'] as String?,
    unitPrice: (json['unitPrice'] as num?)?.toDouble(),
    originalPrice: (json['originalPrice'] as num?)?.toDouble(),
    quantity: json['quantity'] as int?,
    maxQuantity: json['maxQuantity'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'brand': brand,
    'imageUrl': imageUrl,
    'colorName': colorName,
    'size': size,
    'unitPrice': unitPrice,
    'originalPrice': originalPrice,
    'quantity': quantity,
    'maxQuantity': maxQuantity,
  };
}
