part of 'product_list_controller.dart';

enum ProductListStatus { initial, loading, loaded, error }

class ProductListState extends Equatable {
  final ProductListStatus status;
  final ProductQuery query;
  final List<ProductEntity> items;
  final int totalRecord;
  final bool hasMore;
  final bool isLoadingMore;

  /// Set when loading the next page failed; the loaded items stay.
  final bool loadMoreFailed;

  const ProductListState({
    this.status = ProductListStatus.initial,
    this.query = const ProductQuery(),
    this.items = const [],
    this.totalRecord = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.loadMoreFailed = false,
  });

  bool get isEmpty => status == ProductListStatus.loaded && items.isEmpty;

  ProductListState copyWith({
    ProductListStatus? status,
    ProductQuery? query,
    List<ProductEntity>? items,
    int? totalRecord,
    bool? hasMore,
    bool? isLoadingMore,
    bool? loadMoreFailed,
  }) {
    return ProductListState(
      status: status ?? this.status,
      query: query ?? this.query,
      items: items ?? this.items,
      totalRecord: totalRecord ?? this.totalRecord,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
    );
  }

  @override
  List<Object?> get props => [
    status,
    query,
    items,
    totalRecord,
    hasMore,
    isLoadingMore,
    loadMoreFailed,
  ];
}
