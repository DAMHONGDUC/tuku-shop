import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/features/product/domain/entities/description.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_color.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_size.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_tag.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_variant.dart';
import 'package:tuku_shop/src/features/product/domain/entities/review_comment.dart';

class ProductEntity extends Equatable {
  final String name;
  final String brand;

  /// The shop selling this listing (seller feature id).
  final String sellerId;
  final double price;
  final String imageUrl;
  final List<ProductColor> productColors;
  final String id;
  final int purchaserCount;
  final Description? description;
  final List<ReviewComment> reviewComments;
  final double averageRating;
  final List<ProductSize> productSizes;
  final String categoryId;
  final List<String> images;
  final double? originalPrice;
  final Set<ProductTag> tags;
  final List<ProductVariant> variants;
  final String material;
  final String fit;
  final int ratingCount;

  const ProductEntity({
    this.productColors = const [],
    this.productSizes = const [],
    required this.name,
    required this.brand,
    this.sellerId = '',
    required this.price,
    required this.imageUrl,
    required this.id,
    required this.purchaserCount,
    this.description,
    required this.reviewComments,
    required this.averageRating,
    this.categoryId = '',
    this.images = const [],
    this.originalPrice,
    this.tags = const {},
    this.variants = const [],
    this.material = '',
    this.fit = '',
    this.ratingCount = 0,
  });

  bool get isOnSale => originalPrice != null && originalPrice! > price;

  /// Whole-number discount, e.g. 20 for 20 % off; 0 when not on sale.
  int get discountPercent =>
      isOnSale ? ((1 - price / originalPrice!) * 100).round() : 0;

  /// Stock of one color × size; a product without variants is unlimited.
  int stockFor({required String colorName, required String size}) {
    if (variants.isEmpty) return 99;
    return variants
            .firstWhereOrNull((v) => v.colorName == colorName && v.size == size)
            ?.stock ??
        0;
  }

  bool get isInStock => variants.isEmpty || variants.any((v) => v.stock > 0);

  @override
  List<Object?> get props => [
    name,
    brand,
    sellerId,
    price,
    imageUrl,
    productColors,
    id,
    purchaserCount,
    description,
    reviewComments,
    averageRating,
    productSizes,
    categoryId,
    images,
    originalPrice,
    tags,
    variants,
    material,
    fit,
    ratingCount,
  ];
}
