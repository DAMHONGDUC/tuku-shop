part of 'recommended_controller.dart';

class RecommendedState extends Equatable {
  const RecommendedState({
    this.status = LoadStatus.loading,
    this.products = const <ProductEntity>[],
    this.page = 1,
    this.hasMore = false,
    this.loadingMore = false,
  });

  final LoadStatus status;
  final List<ProductEntity> products;
  final int page;
  final bool hasMore;
  final bool loadingMore;

  RecommendedState copyWith({bool? loadingMore}) => RecommendedState(
    status: status,
    products: products,
    page: page,
    hasMore: hasMore,
    loadingMore: loadingMore ?? this.loadingMore,
  );

  @override
  List<Object> get props => <Object>[status, products, page, hasMore, loadingMore];
}
