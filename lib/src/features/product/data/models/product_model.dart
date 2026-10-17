import 'product_color_model.dart';

class ProductModel {
  const ProductModel({
    this.id,
    this.name,
    this.brand,
    this.categoryId,
    this.gender,
    this.price,
    this.compareAtPrice,
    this.rating,
    this.reviewCount,
    this.soldCount,
    this.material,
    this.description,
    this.highlights,
    this.sizes,
    this.colors,
    this.isNew,
    this.isBestSeller,
    this.isEco,
    this.createdAt,
  });

  final String? id;
  final String? name;
  final String? brand;
  final String? categoryId;
  final String? gender;
  final double? price;
  final double? compareAtPrice;
  final double? rating;
  final int? reviewCount;
  final int? soldCount;
  final String? material;
  final String? description;
  final List<String>? highlights;
  final List<String>? sizes;
  final List<ProductColorModel>? colors;
  final bool? isNew;
  final bool? isBestSeller;
  final bool? isEco;
  final String? createdAt;
}
