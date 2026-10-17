import 'package:tuku_shop/src/features/category/data/models/category_model.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';

class CategoryModelToCategoryEntityMapper {
  const CategoryModelToCategoryEntityMapper._();

  static CategoryEntity toEntity(CategoryModel model) => CategoryEntity(
    id: model.id ?? '',
    name: model.name ?? '',
    image: model.image ?? '',
    productCount: model.productCount ?? 0,
  );
}
