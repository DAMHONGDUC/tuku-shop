import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  const OrderItemEntity({
    required this.productId,
    required this.name,
    required this.image,
    required this.color,
    required this.size,
    required this.quantity,
    required this.unitPrice,
  });

  final String productId;
  final String name;
  final String image;
  final String color;
  final String size;
  final int quantity;
  final double unitPrice;

  double get lineTotal => unitPrice * quantity;

  @override
  List<Object> get props => <Object>[
    productId,
    name,
    image,
    color,
    size,
    quantity,
    unitPrice,
  ];
}
