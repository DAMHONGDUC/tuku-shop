import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source_impl.dart';
import 'package:tuku_shop/src/features/product/data/models/product_color_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_page_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

ProductModel _product(
  String id, {
  String name = 'Tee',
  String categoryId = 'tees',
  String gender = 'unisex',
  double price = 20,
  double? compareAtPrice,
  double rating = 4,
  int soldCount = 10,
  List<String> sizes = const <String>['M'],
  List<String> colors = const <String>['Black'],
  String createdAt = '2026-01-01',
}) => ProductModel(
  id: id,
  name: name,
  brand: 'Tuku',
  categoryId: categoryId,
  gender: gender,
  price: price,
  compareAtPrice: compareAtPrice,
  rating: rating,
  soldCount: soldCount,
  sizes: sizes,
  colors: colors
      .map(
        (String c) => ProductColorModel(
          name: c,
          hex: '#000000',
          images: const <String>[],
        ),
      )
      .toList(),
  createdAt: createdAt,
);

final List<ProductModel> _catalogue = <ProductModel>[
  _product(
    'hoodie',
    name: 'Cloud Hoodie',
    categoryId: 'hoodies',
    gender: 'women',
    price: 60,
    sizes: <String>['S', 'M'],
    colors: <String>['Grey'],
    createdAt: '2026-03-01',
  ),
  _product(
    'jogger',
    name: 'Trail Jogger',
    categoryId: 'pants',
    gender: 'men',
    price: 45,
    compareAtPrice: 60,
    rating: 4.8,
    sizes: <String>['L'],
    soldCount: 300,
  ),
  _product(
    'tee',
    name: 'Everyday Tee',
    price: 18,
    rating: 4.2,
    soldCount: 900,
    createdAt: '2026-02-01',
  ),
  _product(
    'pack',
    name: 'Day Pack',
    categoryId: 'bags',
    price: 80,
    compareAtPrice: 100,
    sizes: <String>['One size'],
    colors: <String>['Olive'],
  ),
];

List<String> _ids(List<ProductModel> products) =>
    products.map((ProductModel p) => p.id!).toList();

void main() {
  setUpAll(() => MockLatency.enabled = false);

  group('filter', () {
    List<String> filter(ProductQuery query) =>
        _ids(ProductRemoteDataSourceImpl.filter(_catalogue, query));

    test('no refinements returns everything', () {
      expect(filter(const ProductQuery()), hasLength(_catalogue.length));
    });

    test('keyword matches name and category synonyms, plural or not', () {
      expect(filter(const ProductQuery(keyword: 'hoodies')), <String>[
        'hoodie',
      ]);
      expect(filter(const ProductQuery(keyword: 'backpack')), <String>['pack']);
      expect(filter(const ProductQuery(keyword: 'everyday tee')), <String>[
        'tee',
      ]);
    });

    test('gender keeps that gender plus unisex', () {
      expect(filter(const ProductQuery(gender: Gender.men)), <String>[
        'jogger',
        'tee',
        'pack',
      ]);
    });

    test('price range is inclusive at both ends', () {
      expect(filter(const ProductQuery(minPrice: 45, maxPrice: 60)), <String>[
        'hoodie',
        'jogger',
      ]);
    });

    test('size and colour match any of the chosen values', () {
      expect(filter(const ProductQuery(sizes: <String>{'S', 'L'})), <String>[
        'hoodie',
        'jogger',
      ]);
      expect(filter(const ProductQuery(colors: <String>{'Olive'})), <String>[
        'pack',
      ]);
    });

    test('on sale only keeps marked-down products', () {
      expect(filter(const ProductQuery(onSaleOnly: true)), <String>[
        'jogger',
        'pack',
      ]);
    });
  });

  group('sort', () {
    List<String> sort(ProductSort by) =>
        _ids(ProductRemoteDataSourceImpl.sort(_catalogue, by));

    test('price low to high and high to low', () {
      expect(sort(ProductSort.priceLowHigh), <String>[
        'tee',
        'jogger',
        'hoodie',
        'pack',
      ]);
      expect(sort(ProductSort.priceHighLow), <String>[
        'pack',
        'hoodie',
        'jogger',
        'tee',
      ]);
    });

    test('newest, top rated and best selling', () {
      expect(sort(ProductSort.newest).first, 'hoodie');
      expect(sort(ProductSort.topRated).first, 'jogger');
      expect(sort(ProductSort.bestSelling).first, 'tee');
    });
  });

  group('getProducts paging', () {
    final ProductRemoteDataSourceImpl source = ProductRemoteDataSourceImpl(
      catalogue: _catalogue,
    );

    test('splits the matches into pages of pageSize', () async {
      final ProductPageModel first = await source.getProducts(
        const ProductQuery(sort: ProductSort.priceLowHigh, pageSize: 3),
      );
      final ProductPageModel second = await source.getProducts(
        const ProductQuery(
          sort: ProductSort.priceLowHigh,
          pageSize: 3,
          page: 2,
        ),
      );

      expect(first.total, 4);
      expect(first.totalPages, 2);
      expect(_ids(first.items!), <String>['tee', 'jogger', 'hoodie']);
      expect(_ids(second.items!), <String>['pack']);
    });

    test('a page past the end is empty', () async {
      final ProductPageModel page = await source.getProducts(
        const ProductQuery(pageSize: 3, page: 5),
      );

      expect(page.items, isEmpty);
    });

    test('no matches gives zero pages', () async {
      final ProductPageModel page = await source.getProducts(
        const ProductQuery(keyword: 'tuxedo'),
      );

      expect(page.total, 0);
      expect(page.totalPages, 0);
    });
  });
}
