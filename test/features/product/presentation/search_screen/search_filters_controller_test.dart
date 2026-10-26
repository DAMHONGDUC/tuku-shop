import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/search_screen/filters/search_filters_controller.dart';

import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetProductFacetsUsecase facets;
  late MockGetCategoriesUsecase categories;

  const tFacets = ProductFacets(
    sizes: ['S', 'M'],
    colors: [FacetColor(name: 'Black', hex: '#000000')],
    minPrice: 10,
    maxPrice: 200,
  );
  const tCategories = [
    CategoryEntity(
      id: 'jeans',
      name: 'Jeans',
      imageUrl: '',
      numOfProduct: 5,
      colorHex: '#FFFFFF',
    ),
  ];

  setUp(() {
    facets = MockGetProductFacetsUsecase();
    categories = MockGetCategoriesUsecase();
    when(
      () => facets.call(NoParams()),
    ).thenAnswer((_) async => const Right(tFacets));
    when(
      () => categories.call(NoParams()),
    ).thenAnswer((_) async => const Right(tCategories));
  });

  blocTest<SearchFiltersController, SearchFiltersState>(
    'load returns facets and categories together',
    build: () => SearchFiltersController(facets, categories),
    act: (c) => c.load(),
    expect: () => [
      const SearchFiltersState(),
      const SearchFiltersState(
        status: SearchFiltersStatus.loaded,
        facets: tFacets,
        categories: tCategories,
      ),
    ],
  );

  blocTest<SearchFiltersController, SearchFiltersState>(
    'either request failing shows the error state',
    setUp: () => when(
      () => categories.call(NoParams()),
    ).thenAnswer((_) async => Left(ServerFailure())),
    build: () => SearchFiltersController(facets, categories),
    act: (c) => c.load(),
    expect: () => [
      const SearchFiltersState(),
      const SearchFiltersState(status: SearchFiltersStatus.error),
    ],
  );
}
