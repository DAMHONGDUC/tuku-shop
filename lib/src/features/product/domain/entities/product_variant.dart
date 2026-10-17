import 'package:equatable/equatable.dart';

/// One color × size combination and how many are left.
class ProductVariant extends Equatable {
  final String colorName;
  final String size;
  final int stock;

  const ProductVariant({
    required this.colorName,
    required this.size,
    required this.stock,
  });

  @override
  List<Object?> get props => [colorName, size, stock];
}
