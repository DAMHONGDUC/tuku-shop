import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_tag.dart';

/// Everything a shopper can narrow a product list by. Empty means "all".
class ProductFilters extends Equatable {
  final String? categoryId;
  final ProductTag? tag;
  final bool onSaleOnly;
  final bool inStockOnly;
  final double? minPrice;
  final double? maxPrice;

  /// Products that come in any of these sizes.
  final Set<String> sizes;

  /// Products that come in any of these color names.
  final Set<String> colors;

  /// Average rating at least this, e.g. 4 for "4★ & up".
  final double? minRating;

  const ProductFilters({
    this.categoryId,
    this.tag,
    this.onSaleOnly = false,
    this.inStockOnly = false,
    this.minPrice,
    this.maxPrice,
    this.sizes = const {},
    this.colors = const {},
    this.minRating,
  });

  /// How many filter groups are set, for the filter button badge.
  int get activeCount => [
    categoryId != null,
    tag != null,
    onSaleOnly,
    inStockOnly,
    minPrice != null || maxPrice != null,
    sizes.isNotEmpty,
    colors.isNotEmpty,
    minRating != null,
  ].where((set) => set).length;

  bool get isEmpty => activeCount == 0;

  @override
  List<Object?> get props => [
    categoryId,
    tag,
    onSaleOnly,
    inStockOnly,
    minPrice,
    maxPrice,
    sizes,
    colors,
    minRating,
  ];
}
