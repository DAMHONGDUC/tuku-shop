import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/browse/product_browse_controller.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetProductsUsecase getProducts;
  late MockGetCategoriesUsecase getCategories;

  setUpAll(() => registerFallbackValue(const ProductQuery()));

  setUp(() {
    getProducts = MockGetProductsUsecase();
    getCategories = MockGetCategoriesUsecase();
    when(() => getCategories(const NoParams())).thenAnswer(
      (_) async =>
          const Right<Failure, List<CategoryEntity>>(<CategoryEntity>[]),
    );
  });

  ProductBrowseController build() => ProductBrowseController(
    getProducts: getProducts,
    getCategories: getCategories,
  );

  void answerPages() {
    when(() => getProducts(any())).thenAnswer((Invocation call) async {
      final ProductQuery query = call.positionalArguments.first as ProductQuery;
      return Right<Failure, ProductPage>(
        query.page == 1
            ? Fixtures.page(<String>['a', 'b'], totalPages: 2)
            : Fixtures.page(<String>['c'], page: 2, totalPages: 2),
      );
    });
  }

  blocTest<ProductBrowseController, ProductBrowseState>(
    'init loads the first page',
    build: () {
      answerPages();
      return build();
    },
    act: (ProductBrowseController c) => c.init(const ProductQuery()),
    verify: (ProductBrowseController c) {
      expect(c.state.status, LoadStatus.success);
      expect(c.state.products, hasLength(2));
      expect(c.state.hasMore, isTrue);
    },
  );

  blocTest<ProductBrowseController, ProductBrowseState>(
    'loadMore appends the next page and stops when there is no more',
    build: () {
      answerPages();
      return build();
    },
    act: (ProductBrowseController c) async {
      await c.init(const ProductQuery());
      await c.loadMore();
      await c.loadMore();
    },
    verify: (ProductBrowseController c) {
      expect(c.state.products.map((ProductEntity p) => p.id), <String>[
        'a',
        'b',
        'c',
      ]);
      expect(c.state.hasMore, isFalse);
      verify(() => getProducts(any())).called(2);
    },
  );

  blocTest<ProductBrowseController, ProductBrowseState>(
    'a new sort reloads from page 1 with the sort in the query',
    build: () {
      answerPages();
      return build();
    },
    act: (ProductBrowseController c) async {
      await c.init(const ProductQuery());
      await c.setSort(ProductSort.priceLowHigh);
    },
    verify: (ProductBrowseController c) {
      expect(c.state.query.sort, ProductSort.priceLowHigh);
      verify(
        () => getProducts(const ProductQuery(sort: ProductSort.priceLowHigh)),
      ).called(1);
    },
  );

  blocTest<ProductBrowseController, ProductBrowseState>(
    'setting the same value again does not reload',
    build: () {
      answerPages();
      return build();
    },
    act: (ProductBrowseController c) async {
      await c.init(const ProductQuery());
      await c.setGender(Gender.all);
    },
    verify: (_) => verify(() => getProducts(any())).called(1),
  );

  blocTest<ProductBrowseController, ProductBrowseState>(
    'a failed load ends in failure',
    build: () {
      when(() => getProducts(any())).thenAnswer(
        (_) async => const Left<Failure, ProductPage>(ServerFailure()),
      );
      return build();
    },
    act: (ProductBrowseController c) => c.init(const ProductQuery()),
    verify: (ProductBrowseController c) =>
        expect(c.state.status, LoadStatus.failure),
  );
}
