import 'package:tuku_shop/src/features/product/data/models/product_facets_model.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_facets.dart';

class ProductFacetsModelToProductFacetsMapper {
  const ProductFacetsModelToProductFacetsMapper._();

  static ProductFacets toEntity(ProductFacetsModel model) {
    return ProductFacets(
      sizes: model.sizes ?? const [],
      colors: [
        for (final c in model.colors ?? const <FacetColorModel>[])
          if (c.name != null) FacetColor(name: c.name!, hex: c.hex ?? ''),
      ],
      minPrice: model.minPrice ?? 0,
      maxPrice: model.maxPrice ?? 0,
    );
  }
}
