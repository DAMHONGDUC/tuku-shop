import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/data/mock/category_mock.dart';
import 'package:tuku_shop/src/features/category/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  const CategoryRemoteDataSourceImpl();

  @override
  Future<List<CategoryModel>> getCategories() async {
    await MockLatency.short();
    return CategoryMock.categories;
  }
}
