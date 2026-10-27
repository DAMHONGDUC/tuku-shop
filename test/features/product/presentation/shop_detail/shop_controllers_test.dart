import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/shop_detail/categories/shop_categories_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/shop_detail/header/shop_header_controller.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mock_usecases.dart';

class _GetSeller extends Mock implements GetSellerUsecase {}

class _ToggleFollow extends Mock implements ToggleFollowSellerUsecase {}

Seller _shop({bool followed = false}) => Seller(
  id: 'denim-house',
  name: 'Denim House',
  colorHex: '#3D6E9E',
  rating: 4.6,
  followerCount: followed ? 101 : 100,
  responseRate: 91,
  location: 'Da Nang',
  isFollowed: followed,
);

void main() {
  late _GetSeller getSeller;
  late MockGetProductsUsecase getProducts;
  late _ToggleFollow toggle;

  setUpAll(() => registerFallbackValue(const ProductQuery()));

  setUp(() {
    getSeller = _GetSeller();
    getProducts = MockGetProductsUsecase();
    toggle = _ToggleFollow();
    when(
      () => getSeller.call('denim-house'),
    ).thenAnswer((_) async => Right(_shop()));
  });

  group('ShopHeaderController', () {
    blocTest<ShopHeaderController, ShopHeaderState>(
      'load shows the shop with its listing count',
      setUp: () => when(
        () => getProducts.call(any()),
      ).thenAnswer((_) async => Right(tPage([tProduct()], pages: 7))),
      build: () => ShopHeaderController(getSeller, getProducts, toggle),
      act: (c) => c.load('denim-house'),
      expect: () => [
        const ShopHeaderState(),
        ShopHeaderState(
          status: ShopHeaderStatus.loaded,
          seller: _shop(),
          productCount: 7,
        ),
      ],
      verify: (_) => verify(
        () => getProducts.call(
          const ProductQuery(sellerId: 'denim-house', pageSize: 1),
        ),
      ).called(1),
    );

    blocTest<ShopHeaderController, ShopHeaderState>(
      'follow swaps in the updated shop; a failure counts for the toast',
      setUp: () {
        when(
          () => getProducts.call(any()),
        ).thenAnswer((_) async => Right(tPage([tProduct()])));
        when(
          () => toggle.call('denim-house'),
        ).thenAnswer((_) async => Right(_shop(followed: true)));
      },
      build: () => ShopHeaderController(getSeller, getProducts, toggle),
      act: (c) async {
        await c.load('denim-house');
        await c.toggleFollow();
        when(
          () => toggle.call('denim-house'),
        ).thenAnswer((_) async => Left(CacheFailure()));
        await c.toggleFollow();
      },
      skip: 2,
      verify: (c) {
        expect(c.state.seller!.isFollowed, isTrue);
        expect(c.state.seller!.followerCount, 101);
        expect(c.state.failureCount, 1);
      },
    );
  });

  group('ShopCategoriesController', () {
    late MockGetCategoriesUsecase getCategories;

    const jeans = CategoryEntity(
      id: 'jeans',
      name: 'Jeans',
      imageUrl: '',
      numOfProduct: 5,
    );
    const tops = CategoryEntity(
      id: 'women-tops',
      name: 'Tops',
      imageUrl: '',
      numOfProduct: 5,
    );
    const kids = CategoryEntity(
      id: 'kids',
      name: 'Kids',
      imageUrl: '',
      numOfProduct: 5,
    );

    ProductEntity inCategory(String id, String categoryId) => ProductEntity(
      id: id,
      name: id,
      brand: 'b',
      price: 10,
      imageUrl: '',
      purchaserCount: 0,
      reviewComments: const [],
      averageRating: 4,
      categoryId: categoryId,
    );

    setUp(() {
      getCategories = MockGetCategoriesUsecase();
      when(
        () => getCategories.call(NoParams()),
      ).thenAnswer((_) async => const Right([tops, jeans, kids]));
    });

    blocTest<ShopCategoriesController, ShopCategoriesState>(
      'counts the shop listings per category, in catalog order',
      setUp: () => when(() => getProducts.call(any())).thenAnswer(
        (_) async => Right(
          tPage([
            inCategory('a', 'jeans'),
            inCategory('b', 'women-tops'),
            inCategory('c', 'jeans'),
          ], pages: 1),
        ),
      ),
      build: () => ShopCategoriesController(getProducts, getCategories),
      act: (c) => c.load('denim-house'),
      expect: () => [
        const ShopCategoriesState(),
        const ShopCategoriesState(
          status: ShopCategoriesStatus.loaded,
          items: [(category: tops, count: 1), (category: jeans, count: 2)],
        ),
      ],
    );
  });
}
