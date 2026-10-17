import 'package:equatable/equatable.dart';

/// One product variant in the cart, with a snapshot of what it cost when
/// added.
class CartLine extends Equatable {
  final String productId;
  final String name;
  final String brand;
  final String imageUrl;
  final String colorName;
  final String size;
  final double unitPrice;
  final double? originalPrice;
  final int quantity;

  /// Highest quantity allowed: stock, capped at 10.
  final int maxQuantity;

  const CartLine({
    required this.productId,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.colorName,
    required this.size,
    required this.unitPrice,
    this.originalPrice,
    required this.quantity,
    required this.maxQuantity,
  });

  /// Same product, color and size share one line.
  String get id => '$productId|$colorName|$size';

  double get total => unitPrice * quantity;

  CartLine copyWith({int? quantity}) => CartLine(
    productId: productId,
    name: name,
    brand: brand,
    imageUrl: imageUrl,
    colorName: colorName,
    size: size,
    unitPrice: unitPrice,
    originalPrice: originalPrice,
    quantity: quantity ?? this.quantity,
    maxQuantity: maxQuantity,
  );

  @override
  List<Object?> get props => [
    productId,
    name,
    brand,
    imageUrl,
    colorName,
    size,
    unitPrice,
    originalPrice,
    quantity,
    maxQuantity,
  ];
}
