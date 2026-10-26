import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_filters.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_tag.dart';

enum ProductSort { recommended, newest, priceLowToHigh, priceHighToLow, rating }

/// What a product list asks for: keyword, filters, order and which page.
class ProductQuery extends Equatable {
  final String keyword;
  final String? categoryId;
  final ProductTag? tag;
  final bool onSaleOnly;
  final bool inStockOnly;
  final double? minPrice;
  final double? maxPrice;
  final Set<String> sizes;
  final Set<String> colors;
  final double? minRating;
  final ProductSort sort;
  final int page;
  final int pageSize;

  const ProductQuery({
    this.keyword = '',
    this.categoryId,
    this.tag,
    this.onSaleOnly = false,
    this.inStockOnly = false,
    this.minPrice,
    this.maxPrice,
    this.sizes = const {},
    this.colors = const {},
    this.minRating,
    this.sort = ProductSort.recommended,
    this.page = 1,
    this.pageSize = 10,
  });

  ProductQuery copyWith({
    String? keyword,
    String? categoryId,
    ProductTag? tag,
    bool? onSaleOnly,
    ProductSort? sort,
    int? page,
    int? pageSize,
  }) {
    return ProductQuery(
      keyword: keyword ?? this.keyword,
      categoryId: categoryId ?? this.categoryId,
      tag: tag ?? this.tag,
      onSaleOnly: onSaleOnly ?? this.onSaleOnly,
      inStockOnly: inStockOnly,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sizes: sizes,
      colors: colors,
      minRating: minRating,
      sort: sort ?? this.sort,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  /// The filter part of this query.
  ProductFilters get filters => ProductFilters(
    categoryId: categoryId,
    tag: tag,
    onSaleOnly: onSaleOnly,
    inStockOnly: inStockOnly,
    minPrice: minPrice,
    maxPrice: maxPrice,
    sizes: sizes,
    colors: colors,
    minRating: minRating,
  );

  /// This query with every filter replaced by [filters] (cleared ones
  /// included), back on page 1.
  ProductQuery withFilters(ProductFilters filters) {
    return ProductQuery(
      keyword: keyword,
      categoryId: filters.categoryId,
      tag: filters.tag,
      onSaleOnly: filters.onSaleOnly,
      inStockOnly: filters.inStockOnly,
      minPrice: filters.minPrice,
      maxPrice: filters.maxPrice,
      sizes: filters.sizes,
      colors: filters.colors,
      minRating: filters.minRating,
      sort: sort,
      pageSize: pageSize,
    );
  }

  ProductQuery nextPage() => copyWith(page: page + 1);

  ProductQuery firstPage() => copyWith(page: 1);

  @override
  List<Object?> get props => [
    keyword,
    categoryId,
    tag,
    onSaleOnly,
    inStockOnly,
    minPrice,
    maxPrice,
    sizes,
    colors,
    minRating,
    sort,
    page,
    pageSize,
  ];
}
