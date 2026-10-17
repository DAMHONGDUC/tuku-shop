import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/models/product_color_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_page_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class ProductModelToProductEntityMapper {
  const ProductModelToProductEntityMapper._();

  static ProductEntity toEntity(ProductModel model) => ProductEntity(
    id: model.id ?? '',
    name: model.name ?? '',
    brand: model.brand ?? '',
    categoryId: model.categoryId ?? '',
    gender: Gender.fromName(model.gender),
    price: model.price ?? 0,
    compareAtPrice: model.compareAtPrice,
    rating: model.rating ?? 0,
    reviewCount: model.reviewCount ?? 0,
    soldCount: model.soldCount ?? 0,
    material: model.material ?? '',
    description: model.description ?? '',
    highlights: model.highlights ?? const <String>[],
    sizes: model.sizes ?? const <String>[],
    colors: (model.colors ?? const <ProductColorModel>[])
        .map(
          (ProductColorModel c) => ProductColor(
            name: c.name ?? '',
            hex: c.hex ?? '#000000',
            images: c.images ?? const <String>[],
          ),
        )
        .toList(),
    isNew: model.isNew ?? false,
    isBestSeller: model.isBestSeller ?? false,
    isEco: model.isEco ?? false,
    createdAt: DateTime.tryParse(model.createdAt ?? '') ?? DateTime(2026),
  );

  static ProductPage pageToEntity(ProductPageModel model) => ProductPage(
    items: (model.items ?? const <ProductModel>[]).map(toEntity).toList(),
    page: model.page ?? 1,
    totalPages: model.totalPages ?? 0,
    total: model.total ?? 0,
  );
}
