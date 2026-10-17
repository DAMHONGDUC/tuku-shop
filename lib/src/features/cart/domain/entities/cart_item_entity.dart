import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  const CartItemEntity({
    required this.id,
    required this.productId,
    required this.name,
    required this.brand,
    required this.image,
    required this.color,
    required this.size,
    required this.unitPrice,
    required this.quantity,
    this.compareAtPrice,
  });

  /// One line per product, colour and size — adding the same combination
  /// again raises its quantity.
  final String id;
  final String productId;
  final String name;
  final String brand;
  final String image;
  final String color;
  final String size;
  final double unitPrice;
  final double? compareAtPrice;
  final int quantity;

  double get lineTotal => unitPrice * quantity;

  CartItemEntity copyWith({int? quantity}) => CartItemEntity(
    id: id,
    productId: productId,
    name: name,
    brand: brand,
    image: image,
    color: color,
    size: size,
    unitPrice: unitPrice,
    compareAtPrice: compareAtPrice,
    quantity: quantity ?? this.quantity,
  );

  @override
  List<Object?> get props => <Object?>[
    id,
    productId,
    name,
    brand,
    image,
    color,
    size,
    unitPrice,
    compareAtPrice,
    quantity,
  ];
}
