import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/category/presentation/categories_section/categories_section_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetCategoriesUsecase usecase;
  late CategoriesController controller;

  const tCategories = [
    CategoryEntity(
      id: 'women-tops',
      name: 'Luxury',
      imageUrl: 'assets/images/category/c0.png',
      numOfProduct: 120,
    ),
  ];

  setUp(() {
    usecase = MockGetCategoriesUsecase();
    controller = CategoriesController(usecase);
  });

  tearDown(() => controller.close());

  blocTest<CategoriesController, CategoriesState>(
    'emits [Loading, Loaded] when the usecase succeeds',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => const Right(tCategories));
    },
    build: () => controller,
    act: (c) => c.getData(),
    expect: () => [
      CategoriesLoading(),
      const CategoriesLoaded(categories: tCategories),
    ],
  );

  blocTest<CategoriesController, CategoriesState>(
    'emits [Loading, Error] when the usecase fails',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => controller,
    act: (c) => c.getData(),
    expect: () => [
      CategoriesLoading(),
      const CategoriesError(errorMsg: 'something wrong'),
    ],
  );
}
