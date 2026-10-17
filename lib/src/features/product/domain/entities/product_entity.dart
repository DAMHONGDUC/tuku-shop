import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import 'product_color.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.categoryId,
    required this.gender,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.soldCount,
    required this.material,
    required this.description,
    required this.highlights,
    required this.sizes,
    required this.colors,
    required this.isNew,
    required this.isBestSeller,
    required this.isEco,
    required this.createdAt,
    this.compareAtPrice,
  });

  final String id;
  final String name;
  final String brand;
  final String categoryId;
  final Gender gender;
  final double price;

  /// The price before markdown; null when the product is not on sale.
  final double? compareAtPrice;
  final double rating;
  final int reviewCount;
  final int soldCount;
  final String material;
  final String description;
  final List<String> highlights;
  final List<String> sizes;
  final List<ProductColor> colors;
  final bool isNew;
  final bool isBestSeller;
  final bool isEco;
  final DateTime createdAt;

  bool get isOnSale => compareAtPrice != null && compareAtPrice! > price;

  String get coverImage => colors.isEmpty || colors.first.images.isEmpty
      ? ''
      : colors.first.images.first;

  /// A second photo for the card's hover-less "flip" — the same colour from
  /// another angle when there is one.
  String? get alternateImage {
    if (colors.isEmpty) return null;
    if (colors.first.images.length > 1) return colors.first.images[1];
    if (colors.length > 1) return colors[1].images.first;
    return null;
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    brand,
    categoryId,
    gender,
    price,
    compareAtPrice,
    rating,
    reviewCount,
    soldCount,
    material,
    description,
    highlights,
    sizes,
    colors,
    isNew,
    isBestSeller,
    isEco,
    createdAt,
  ];
}
