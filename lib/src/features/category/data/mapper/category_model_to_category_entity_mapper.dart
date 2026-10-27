import 'package:tuku_shop/src/features/category/data/models/category_model.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';

class CategoryModelToCategoryEntityMapper {
  const CategoryModelToCategoryEntityMapper._();

  static CategoryEntity toEntity(CategoryModel model) {
    return CategoryEntity(
      id: model.id ?? '',
      name: model.name ?? '',
      imageUrl: model.imageUrl ?? '',
      numOfProduct: model.numOfProduct ?? 0,
      colorHex: model.colorHex ?? '#F2F2F2',
    );
  }
}
