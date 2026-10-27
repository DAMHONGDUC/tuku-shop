import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/models/review_comment_model.dart';
import 'package:tuku_shop/src/features/product/domain/entities/review_comment.dart';

class ReviewAssetModelToReviewCommentEntityMapper {
  const ReviewAssetModelToReviewCommentEntityMapper._();

  static ReviewAsset toEntity(ReviewAssetModel model) {
    return ReviewAsset(
      url: model.url ?? '',
      type: AssetTypeExtension.fromString(model.type ?? ''),
    );
  }
}

class ReviewCommentModelToReviewCommentEntityMapper {
  const ReviewCommentModelToReviewCommentEntityMapper._();

  static ReviewComment toEntity(ReviewCommentModel model) {
    return ReviewComment(
      id: model.id ?? '',
      userName: model.userName ?? '',
      comment: model.comment ?? '',
      rating: model.rating ?? 0,
      createdAt: model.createdAt ?? '',
      colorName: model.colorName ?? '',
      size: model.size ?? '',
      assets:
          model.assets
              ?.map(
                (e) => ReviewAssetModelToReviewCommentEntityMapper.toEntity(e),
              )
              .toList() ??
          [],
    );
  }
}
