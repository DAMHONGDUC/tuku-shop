import 'package:tuku_shop/src/features/product/data/models/description_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_color_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_size_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_variant_model.dart';
import 'package:tuku_shop/src/features/product/data/models/review_comment_model.dart';

class ProductModel {
  final String? id;
  final String? name;
  final String? brand;

  /// The shop selling this listing.
  final String? sellerId;
  final double? price;
  final String? imageUrl;
  final int? purchaserCount;
  final double? averageRating;
  final List<ProductColorModel>? productColors;
  final List<ProductSizeModel>? productSizes;

  /// `size` or `model`: what [productSizes] holds.
  final String? secondOption;
  final DescriptionModel? description;
  final List<ReviewCommentModel>? reviewComments;
  final String? categoryId;
  final List<String>? images;
  final double? originalPrice;
  final List<String>? tags;
  final List<ProductVariantModel>? variants;
  final String? material;
  final String? fit;
  final int? ratingCount;

  const ProductModel({
    this.id,
    this.name,
    this.brand,
    this.sellerId,
    this.price,
    this.imageUrl,
    this.purchaserCount,
    this.averageRating,
    this.productColors,
    this.productSizes,
    this.secondOption,
    this.description,
    this.reviewComments,
    this.categoryId,
    this.images,
    this.originalPrice,
    this.tags,
    this.variants,
    this.material,
    this.fit,
    this.ratingCount,
  });
}
