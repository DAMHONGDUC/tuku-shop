import 'package:equatable/equatable.dart';

import 'review_entity.dart';

class ReviewsPage extends Equatable {
  const ReviewsPage({
    required this.summary,
    required this.items,
    required this.page,
    required this.hasMore,
  });

  final ReviewSummary summary;
  final List<ReviewEntity> items;
  final int page;
  final bool hasMore;

  @override
  List<Object> get props => <Object>[summary, items, page, hasMore];
}
