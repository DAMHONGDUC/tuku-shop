class FacetColorModel {
  final String? name;
  final String? hex;

  const FacetColorModel({this.name, this.hex});
}

/// The filter options the catalog API returns.
class ProductFacetsModel {
  final List<String>? sizes;
  final List<FacetColorModel>? colors;
  final double? minPrice;
  final double? maxPrice;

  const ProductFacetsModel({
    this.sizes,
    this.colors,
    this.minPrice,
    this.maxPrice,
  });
}
