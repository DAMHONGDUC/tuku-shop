import 'package:tuku_shop/src/features/product/data/models/review_comment_model.dart';

class ReviewsPageModel {
  final List<ReviewCommentModel>? items;
  final int? currentPage;
  final int? totalPage;
  final int? totalRecord;

  const ReviewsPageModel({
    this.items,
    this.currentPage,
    this.totalPage,
    this.totalRecord,
  });
}
