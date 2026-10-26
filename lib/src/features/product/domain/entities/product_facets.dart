import 'package:equatable/equatable.dart';

/// A color the catalog offers, for the filter swatches.
class FacetColor extends Equatable {
  final String name;
  final String hex;

  const FacetColor({required this.name, required this.hex});

  @override
  List<Object?> get props => [name, hex];
}

/// What the catalog can be filtered by: sizes and colors in stock somewhere,
/// and the price range, as a search API's facets endpoint would return.
class ProductFacets extends Equatable {
  final List<String> sizes;
  final List<FacetColor> colors;
  final double minPrice;
  final double maxPrice;

  const ProductFacets({
    required this.sizes,
    required this.colors,
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  List<Object?> get props => [sizes, colors, minPrice, maxPrice];
}
