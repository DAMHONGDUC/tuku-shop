part of 'product_reviews_controller.dart';

enum ProductReviewsStatus { loading, loaded, error }

class ProductReviewsState extends Equatable {
  final ProductReviewsStatus status;
  final List<ReviewComment> items;
  final int page;
  final int totalRecord;
  final bool hasMore;
  final bool isLoadingMore;

  /// The variation the list is narrowed to, if any.
  final String? colorFilter;
  final String? sizeFilter;

  const ProductReviewsState({
    this.status = ProductReviewsStatus.loading,
    this.items = const [],
    this.page = 0,
    this.totalRecord = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.colorFilter,
    this.sizeFilter,
  });

  bool get isFiltered => colorFilter != null || sizeFilter != null;

  ProductReviewsState copyWith({
    ProductReviewsStatus? status,
    List<ReviewComment>? items,
    int? page,
    int? totalRecord,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ProductReviewsState(
      status: status ?? this.status,
      items: items ?? this.items,
      page: page ?? this.page,
      totalRecord: totalRecord ?? this.totalRecord,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      colorFilter: colorFilter,
      sizeFilter: sizeFilter,
    );
  }

  @override
  List<Object?> get props => [
    status,
    items,
    page,
    totalRecord,
    hasMore,
    isLoadingMore,
    colorFilter,
    sizeFilter,
  ];
}
