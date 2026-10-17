import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Everything a product grid can be narrowed by. One type for search, the
/// shop tab and a category list, so they filter identically.
class ProductQuery extends Equatable {
  const ProductQuery({
    this.keyword = '',
    this.categoryId,
    this.gender = Gender.all,
    this.sort = ProductSort.recommended,
    this.minPrice,
    this.maxPrice,
    this.sizes = const <String>{},
    this.colors = const <String>{},
    this.onSaleOnly = false,
    this.newOnly = false,
    this.page = 1,
    this.pageSize = AppConstants.pageSize,
  });

  factory ProductQuery.fromArgs(ProductListArgs args) => ProductQuery(
    categoryId: args.categoryId,
    gender: args.gender,
    sort: args.sort,
    onSaleOnly: args.onSaleOnly,
    newOnly: args.newOnly,
  );

  final String keyword;
  final String? categoryId;
  final Gender gender;
  final ProductSort sort;
  final double? minPrice;
  final double? maxPrice;
  final Set<String> sizes;
  final Set<String> colors;
  final bool onSaleOnly;
  final bool newOnly;
  final int page;
  final int pageSize;

  /// How many refinements beyond the category and gender are on — the
  /// number on the filter button.
  int get activeFilterCount =>
      (minPrice != null || maxPrice != null ? 1 : 0) +
      (sizes.isEmpty ? 0 : 1) +
      (colors.isEmpty ? 0 : 1) +
      (onSaleOnly ? 1 : 0) +
      (newOnly ? 1 : 0);

  ProductQuery copyWith({
    String? keyword,
    String? Function()? categoryId,
    Gender? gender,
    ProductSort? sort,
    double? Function()? minPrice,
    double? Function()? maxPrice,
    Set<String>? sizes,
    Set<String>? colors,
    bool? onSaleOnly,
    bool? newOnly,
    int? page,
    int? pageSize,
  }) => ProductQuery(
    keyword: keyword ?? this.keyword,
    categoryId: categoryId == null ? this.categoryId : categoryId(),
    gender: gender ?? this.gender,
    sort: sort ?? this.sort,
    minPrice: minPrice == null ? this.minPrice : minPrice(),
    maxPrice: maxPrice == null ? this.maxPrice : maxPrice(),
    sizes: sizes ?? this.sizes,
    colors: colors ?? this.colors,
    onSaleOnly: onSaleOnly ?? this.onSaleOnly,
    newOnly: newOnly ?? this.newOnly,
    page: page ?? this.page,
    pageSize: pageSize ?? this.pageSize,
  );

  /// The same filters with every refinement cleared.
  ProductQuery cleared() => ProductQuery(
    keyword: keyword,
    categoryId: categoryId,
    gender: gender,
    sort: sort,
    pageSize: pageSize,
  );

  @override
  List<Object?> get props => <Object?>[
    keyword,
    categoryId,
    gender,
    sort,
    minPrice,
    maxPrice,
    sizes,
    colors,
    onSaleOnly,
    newOnly,
    page,
    pageSize,
  ];
}
