import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:tuku_shop/src/features/category/data/mapper/category_model_to_category_entity_mapper.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl({required this.dataSource});

  final CategoryRemoteDataSource dataSource;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final List<CategoryEntity> categories = (await dataSource.getCategories())
          .map(CategoryModelToCategoryEntityMapper.toEntity)
          .toList();
      return Right<Failure, List<CategoryEntity>>(categories);
    } catch (e, stackTrace) {
      SdLogger.error(
        'CategoryRepository',
        'Load failed',
        error: e,
        stackTrace: stackTrace,
      );
      return const Left<Failure, List<CategoryEntity>>(ServerFailure());
    }
  }
}
