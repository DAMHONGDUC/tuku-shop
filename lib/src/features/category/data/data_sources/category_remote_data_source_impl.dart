import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/data/mock/category_mock.dart';
import 'package:tuku_shop/src/features/category/data/models/category_model.dart';

import 'category_remote_data_source.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  const CategoryRemoteDataSourceImpl();

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      await MockLatency.wait();
      return CategoryMock.categories;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
