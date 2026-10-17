import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_tag.dart';

enum ProductSort { recommended, newest, priceLowToHigh, priceHighToLow, rating }

/// What a product list asks for: filters, order and which page.
class ProductQuery extends Equatable {
  final String keyword;
  final String? categoryId;
  final ProductTag? tag;
  final bool onSaleOnly;
  final ProductSort sort;
  final int page;
  final int pageSize;

  const ProductQuery({
    this.keyword = '',
    this.categoryId,
    this.tag,
    this.onSaleOnly = false,
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
      sort: sort ?? this.sort,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
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
    sort,
    page,
    pageSize,
  ];
}
