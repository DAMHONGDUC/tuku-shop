import 'review_model.dart';

class ReviewsPageModel {
  const ReviewsPageModel({
    this.average,
    this.total,
    this.distribution,
    this.items,
    this.page,
    this.hasMore,
  });

  final double? average;
  final int? total;
  final Map<int, int>? distribution;
  final List<ReviewModel>? items;
  final int? page;
  final bool? hasMore;
}
