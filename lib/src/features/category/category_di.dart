import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:tuku_shop/src/features/category/data/repositories/category_repository_impl.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/category/presentation/categories_section/categories_section_controller.dart';

class CategoryDi {
  static void config() {
    getIt.registerLazySingleton<CategoryRemoteDataSource>(
      () => const CategoryRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(dataSource: getIt()),
    );
    getIt.registerLazySingleton<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(getIt()),
    );
    getIt.registerFactory<CategoriesSectionController>(
      () => CategoriesSectionController(getIt()),
    );
  }
}
