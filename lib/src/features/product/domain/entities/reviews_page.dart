import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/features/product/domain/entities/review_comment.dart';

class ReviewsPage extends Equatable {
  final List<ReviewComment> items;
  final int currentPage;
  final int totalPage;
  final int totalRecord;

  const ReviewsPage({
    required this.items,
    required this.currentPage,
    required this.totalPage,
    required this.totalRecord,
  });

  bool get hasMore => currentPage < totalPage;

  @override
  List<Object?> get props => [items, currentPage, totalPage, totalRecord];
}
