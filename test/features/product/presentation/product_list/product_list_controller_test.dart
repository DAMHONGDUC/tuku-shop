import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetProductsUsecase usecase;
  final p1 = tProduct(id: 'p1');
  final p2 = tProduct(id: 'p2');
  const q1 = ProductQuery(categoryId: 'jeans');
  final q2 = q1.nextPage();

  setUpAll(() => registerFallbackValue(const ProductQuery()));
  setUp(() => usecase = MockGetProductsUsecase());

  blocTest<ProductListController, ProductListState>(
    'load emits loading then the first page',
    setUp: () => when(
      () => usecase.call(q1),
    ).thenAnswer((_) async => Right(tPage([p1]))),
    build: () => ProductListController(usecase),
    act: (c) => c.load(q1),
    expect: () => [
      const ProductListState(status: ProductListStatus.loading, query: q1),
      ProductListState(
        status: ProductListStatus.loaded,
        query: q1,
        items: [p1],
        totalRecord: 2,
        hasMore: true,
      ),
    ],
  );

  blocTest<ProductListController, ProductListState>(
    'loadMore appends the next page and keeps loaded items on failure',
    setUp: () {
      when(() => usecase.call(q1)).thenAnswer((_) async => Right(tPage([p1])));
      when(
        () => usecase.call(q2),
      ).thenAnswer((_) async => Right(tPage([p2], page: 2)));
    },
    build: () => ProductListController(usecase),
    act: (c) async {
      await c.load(q1);
      await c.loadMore();
      await c.loadMore(); // no more pages: ignored
    },
    skip: 2,
    expect: () => [
      ProductListState(
        status: ProductListStatus.loaded,
        query: q1,
        items: [p1],
        totalRecord: 2,
        hasMore: true,
        isLoadingMore: true,
      ),
      ProductListState(
        status: ProductListStatus.loaded,
        query: q2,
        items: [p1, p2],
        totalRecord: 2,
        hasMore: false,
      ),
    ],
  );

  blocTest<ProductListController, ProductListState>(
    'a failed next page flags loadMoreFailed and keeps items',
    setUp: () {
      when(() => usecase.call(q1)).thenAnswer((_) async => Right(tPage([p1])));
      when(
        () => usecase.call(q2),
      ).thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => ProductListController(usecase),
    act: (c) async {
      await c.load(q1);
      await c.loadMore();
    },
    verify: (c) {
      expect(c.state.items, [p1]);
      expect(c.state.loadMoreFailed, isTrue);
      expect(c.state.isLoadingMore, isFalse);
    },
  );

  blocTest<ProductListController, ProductListState>(
    'changeSort reloads page 1 with the new order',
    setUp: () => when(
      () => usecase.call(any()),
    ).thenAnswer((_) async => Right(tPage([p1], pages: 1))),
    build: () => ProductListController(usecase),
    act: (c) => c.changeSort(ProductSort.priceLowToHigh),
    verify: (_) => verify(
      () => usecase.call(const ProductQuery(sort: ProductSort.priceLowToHigh)),
    ).called(1),
  );

  blocTest<ProductListController, ProductListState>(
    'search waits for typing to pause, then searches once',
    setUp: () => when(
      () => usecase.call(any()),
    ).thenAnswer((_) async => Right(tPage([p1], pages: 1))),
    build: () => ProductListController(usecase),
    act: (c) {
      c.search('je');
      c.search('jean');
      c.search('jeans');
    },
    wait: ProductListController.searchDebounce * 2,
    verify: (_) {
      verify(
        () => usecase.call(const ProductQuery(keyword: 'jeans')),
      ).called(1);
      verifyNoMoreInteractions(usecase);
    },
  );

  blocTest<ProductListController, ProductListState>(
    'load emits error when the usecase fails',
    setUp: () => when(
      () => usecase.call(any()),
    ).thenAnswer((_) async => Left(ServerFailure())),
    build: () => ProductListController(usecase),
    act: (c) => c.load(q1),
    expect: () => [
      const ProductListState(status: ProductListStatus.loading, query: q1),
      const ProductListState(status: ProductListStatus.error, query: q1),
    ],
  );

  group('filters', () {
    const filters = ProductFilters(minPrice: 20, sizes: {'M'});
    final filtered = const ProductQuery(
      sort: ProductSort.priceLowToHigh,
    ).withFilters(filters);

    blocTest<ProductListController, ProductListState>(
      'applyFilters loads filters and sort without a keyword',
      setUp: () => when(
        () => usecase.call(filtered),
      ).thenAnswer((_) async => Right(tPage([p1], pages: 1))),
      build: () => ProductListController(usecase),
      act: (c) => c.applyFilters(filters, ProductSort.priceLowToHigh),
      expect: () => [
        ProductListState(status: ProductListStatus.loading, query: filtered),
        ProductListState(
          status: ProductListStatus.loaded,
          query: filtered,
          items: [p1],
          totalRecord: 1,
        ),
      ],
    );

    blocTest<ProductListController, ProductListState>(
      'clearing every filter with no keyword clears the list but keeps sort',
      build: () => ProductListController(usecase),
      act: (c) => c.applyFilters(const ProductFilters(), ProductSort.rating),
      expect: () => [
        const ProductListState(query: ProductQuery(sort: ProductSort.rating)),
      ],
      verify: (_) => verifyNever(() => usecase.call(any())),
    );

    blocTest<ProductListController, ProductListState>(
      'an empty keyword keeps the filters and their results',
      setUp: () => when(
        () => usecase.call(any()),
      ).thenAnswer((_) async => Right(tPage([p1], pages: 1))),
      build: () => ProductListController(usecase),
      seed: () => ProductListState(
        status: ProductListStatus.loaded,
        query: filtered.copyWith(keyword: 'jeans'),
        items: [p2],
      ),
      act: (c) => c.search(''),
      wait: ProductListController.searchDebounce * 2,
      verify: (c) {
        expect(c.state.query.filters, filters);
        expect(c.state.query.keyword, isEmpty);
        verify(() => usecase.call(filtered)).called(1);
      },
    );
  });
}
