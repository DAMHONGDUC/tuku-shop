part of 'product_browse_controller.dart';

class ProductBrowseState extends Equatable {
  const ProductBrowseState({
    this.query = const ProductQuery(),
    this.status = LoadStatus.loading,
    this.products = const <ProductEntity>[],
    this.categories = const <CategoryEntity>[],
    this.page = 1,
    this.hasMore = false,
    this.loadingMore = false,
    this.total = 0,
  });

  final ProductQuery query;
  final LoadStatus status;
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final int page;
  final bool hasMore;
  final bool loadingMore;
  final int total;

  ProductBrowseState copyWith({
    ProductQuery? query,
    LoadStatus? status,
    List<ProductEntity>? products,
    List<CategoryEntity>? categories,
    int? page,
    bool? hasMore,
    bool? loadingMore,
    int? total,
  }) => ProductBrowseState(
    query: query ?? this.query,
    status: status ?? this.status,
    products: products ?? this.products,
    categories: categories ?? this.categories,
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
    loadingMore: loadingMore ?? this.loadingMore,
    total: total ?? this.total,
  );

  @override
  List<Object> get props => <Object>[
    query,
    status,
    products,
    categories,
    page,
    hasMore,
    loadingMore,
    total,
  ];
}
