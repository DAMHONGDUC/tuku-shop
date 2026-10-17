import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/data/models/category_model.dart';
import 'package:tuku_shop/src/features/category/data/repositories/category_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_repositories.dart';

void main() {
  late MockCategoryRemoteDataSource dataSource;
  late CategoryRepositoryImpl repository;

  setUp(() {
    dataSource = MockCategoryRemoteDataSource();
    repository = CategoryRepositoryImpl(dataSource: dataSource);
  });

  const tCategoryModel = CategoryModel(
    id: 'women-tops',
    name: 'Luxury',
    imageUrl: 'assets/images/category/c0.png',
    numOfProduct: 120,
  );

  test('should map the list of models to a list of entities', () async {
    when(
      () => dataSource.getCategories(),
    ).thenAnswer((_) async => [tCategoryModel]);

    final result = await repository.getCategories();

    result.fold((_) => fail('expected Right'), (categories) {
      expect(categories.length, 1);
      expect(categories.first.id, tCategoryModel.id);
      expect(categories.first.name, tCategoryModel.name);
    });
  });

  test('should return a ServerFailure when the data source throws', () async {
    when(() => dataSource.getCategories()).thenThrow(const ServerException());

    final result = await repository.getCategories();

    expect(result, Left(ServerFailure()));
  });
}
