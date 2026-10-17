import 'package:tuku_shop/src/features/product/data/models/review_model.dart';
import 'package:tuku_shop/src/features/product/data/models/reviews_page_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class ReviewModelToReviewEntityMapper {
  const ReviewModelToReviewEntityMapper._();

  static ReviewEntity toEntity(ReviewModel model) => ReviewEntity(
    id: model.id ?? '',
    author: model.author ?? '',
    rating: model.rating ?? 5,
    title: model.title ?? '',
    comment: model.comment ?? '',
    createdAt: DateTime.tryParse(model.createdAt ?? '') ?? DateTime(2026),
    size: model.size ?? '',
    color: model.color ?? '',
    helpfulCount: model.helpfulCount ?? 0,
    photos: model.photos ?? const <String>[],
  );

  static ReviewsPage pageToEntity(ReviewsPageModel model) => ReviewsPage(
    summary: ReviewSummary(
      average: model.average ?? 0,
      total: model.total ?? 0,
      distribution: model.distribution ?? const <int, int>{},
    ),
    items: (model.items ?? const <ReviewModel>[]).map(toEntity).toList(),
    page: model.page ?? 1,
    hasMore: model.hasMore ?? false,
  );
}
