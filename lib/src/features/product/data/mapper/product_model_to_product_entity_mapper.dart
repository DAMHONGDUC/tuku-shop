import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'description_model_to_description_entity_mapper.dart';
import 'review_comment_model_to_review_comment_entity_mapper.dart';
import 'product_color_model_to_product_color_entity_mapper.dart';
import 'product_size_model_to_product_size_entity_mapper.dart';

class ProductModelToProductEntityMapper {
  const ProductModelToProductEntityMapper._();

  static ProductEntity toEntity(ProductModel model) {
    return ProductEntity(
      id: model.id ?? '',
      name: model.name ?? '',
      brand: model.brand ?? '',
      price: model.price ?? 0,
      imageUrl: model.imageUrl ?? '',
      purchaserCount: model.purchaserCount ?? 0,
      averageRating: model.averageRating ?? 0,
      productColors:
          model.productColors
              ?.map(ProductColorModelToProductColorEntityMapper.toEntity)
              .toList() ??
          [],
      productSizes:
          model.productSizes
              ?.map(ProductSizeModelToProductSizeEntityMapper.toEntity)
              .toList() ??
          [],
      description: model.description != null
          ? DescriptionModelToDescriptionEntityMapper.toEntity(
              model.description!,
            )
          : null,
      reviewComments:
          model.reviewComments
              ?.map(ReviewCommentModelToReviewCommentEntityMapper.toEntity)
              .toList() ??
          [],
      categoryId: model.categoryId ?? '',
      images: model.images ?? [if (model.imageUrl != null) model.imageUrl!],
      originalPrice: model.originalPrice,
      tags: {
        for (final tag in model.tags ?? const <String>[])
          ?ProductTag.values.asNameMap()[tag],
      },
      variants:
          model.variants
              ?.map(
                (v) => ProductVariant(
                  colorName: v.colorName ?? '',
                  size: v.size ?? '',
                  stock: v.stock ?? 0,
                ),
              )
              .toList() ??
          [],
      material: model.material ?? '',
      fit: model.fit ?? '',
      ratingCount: model.ratingCount ?? model.reviewComments?.length ?? 0,
    );
  }
}
