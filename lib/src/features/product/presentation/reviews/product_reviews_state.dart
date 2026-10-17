part of 'product_reviews_controller.dart';

class ProductReviewsState extends Equatable {
  const ProductReviewsState({
    this.status = LoadStatus.loading,
    this.summary,
    this.items = const <ReviewEntity>[],
    this.page = 1,
    this.hasMore = false,
    this.loadingMore = false,
    this.starFilter,
  });

  final LoadStatus status;
  final ReviewSummary? summary;
  final List<ReviewEntity> items;
  final int page;
  final bool hasMore;
  final bool loadingMore;

  /// Show only reviews with this many stars; null shows all.
  final int? starFilter;

  List<ReviewEntity> get visible => starFilter == null
      ? items
      : items.where((ReviewEntity r) => r.rating == starFilter).toList();

  ProductReviewsState copyWith({
    LoadStatus? status,
    ReviewSummary? summary,
    List<ReviewEntity>? items,
    int? page,
    bool? hasMore,
    bool? loadingMore,
    int? Function()? starFilter,
  }) => ProductReviewsState(
    status: status ?? this.status,
    summary: summary ?? this.summary,
    items: items ?? this.items,
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
    loadingMore: loadingMore ?? this.loadingMore,
    starFilter: starFilter == null ? this.starFilter : starFilter(),
  );

  @override
  List<Object?> get props => <Object?>[
    status,
    summary,
    items,
    page,
    hasMore,
    loadingMore,
    starFilter,
  ];
}
