import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int numOfProduct;

  /// Soft background for the category card, as `#RRGGBB`.
  final String colorHex;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.numOfProduct,
    this.colorHex = '#F2F2F2',
  });

  @override
  List<Object> get props => [id, name, imageUrl, numOfProduct, colorHex];
}
