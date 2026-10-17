import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/models/product_data_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/review_comment_model.dart';
import 'package:tuku_shop/src/features/product/data/models/reviews_page_model.dart';
import 'package:tuku_shop/src/features/product/data/repositories/product_repository_impl.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../../../../helpers/mock_repositories.dart';

void main() {
  late MockProductRemoteDataSource dataSource;
  late MockSearchHistoryLocalDataSource history;
  late ProductRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(const ProductQuery()));

  setUp(() {
    dataSource = MockProductRemoteDataSource();
    history = MockSearchHistoryLocalDataSource();
    repository = ProductRepositoryImpl(
      dataSource: dataSource,
      searchHistory: history,
    );
  });

  const tProductModel = ProductModel(
    id: 'wd1',
    name: 'Floral Midi Dress',
    brand: 'Aurora',
    price: 69,
    originalPrice: 79,
    imageUrl: 'a.jpg',
    images: ['a.jpg', 'b.jpg'],
    tags: ['sale', 'unknown-tag'],
    purchaserCount: 120,
    averageRating: 4.5,
  );

  group('getProducts', () {
    test('maps the page and drops unknown tags', () async {
      when(() => dataSource.getProducts(any())).thenAnswer(
        (_) async => const ProductsDataModel(
          items: [tProductModel],
          totalPage: 3,
          currentPage: 1,
          totalRecord: 25,
        ),
      );

      final result = await repository.getProducts(const ProductQuery());

      result.fold((_) => fail('expected Right'), (page) {
        expect(page.totalRecord, 25);
        final product = page.items.single;
        expect(product.tags, {ProductTag.sale});
        expect(product.images, ['a.jpg', 'b.jpg']);
        expect(product.isOnSale, isTrue);
        expect(product.discountPercent, 13);
      });
    });

    test('returns a ServerFailure when the data source throws', () async {
      when(
        () => dataSource.getProducts(any()),
      ).thenThrow(const ServerException());

      expect(
        await repository.getProducts(const ProductQuery()),
        Left(ServerFailure()),
      );
    });
  });

  test('getProductDetail maps the model', () async {
    when(
      () => dataSource.getProductDetail(productId: 'wd1'),
    ).thenAnswer((_) async => tProductModel);

    final result = await repository.getProductDetail(productId: 'wd1');

    expect(result.getOrElse(() => throw 'Left').name, 'Floral Midi Dress');
  });

  test('getProductReviews maps the page', () async {
    when(
      () =>
          dataSource.getProductReviews(productId: 'wd1', page: 2, pageSize: 5),
    ).thenAnswer(
      (_) async => const ReviewsPageModel(
        items: [ReviewCommentModel(id: 'r6', userName: 'Mia', rating: 5)],
        currentPage: 2,
        totalPage: 5,
        totalRecord: 24,
      ),
    );

    final result = await repository.getProductReviews(
      productId: 'wd1',
      page: 2,
      pageSize: 5,
    );

    final page = result.getOrElse(() => throw 'Left');
    expect(page.items.single.userName, 'Mia');
    expect(page.hasMore, isTrue);
  });

  group('search suggestions', () {
    test('combines recent and trending', () async {
      when(() => history.getRecent()).thenAnswer((_) async => ['jeans']);
      when(
        () => dataSource.getTrendingSearches(),
      ).thenAnswer((_) async => ['hoodie']);

      final result = await repository.getSearchSuggestions();

      expect(
        result,
        const Right(SearchSuggestions(recent: ['jeans'], trending: ['hoodie'])),
      );
    });

    test('a failing history store is a CacheFailure', () async {
      when(() => history.add('x')).thenThrow(const CacheException());

      expect(await repository.saveRecentSearch('x'), Left(CacheFailure()));
    });
  });
}
