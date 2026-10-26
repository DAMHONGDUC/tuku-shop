import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source_impl.dart';
import 'package:tuku_shop/src/features/product/data/models/product_data_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_facets_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

void main() {
  const dataSource = ProductRemoteDataSourceImpl();

  /// Runs [query] with the mock latency skipped.
  ProductsDataModel run(ProductQuery query) {
    late ProductsDataModel result;
    fakeAsync((async) {
      dataSource.getProducts(query).then((value) => result = value);
      async.elapse(MockLatency.max);
    });
    return result;
  }

  test('pages 10 at a time and reports totals', () {
    final first = run(const ProductQuery());
    expect(first.items!.length, 10);
    expect(first.totalRecord, 69);
    expect(first.totalPage, 7);

    final last = run(const ProductQuery(page: 7));
    expect(last.items!.length, 9);
    expect(run(const ProductQuery(page: 8)).items, isEmpty);
  });

  test('filters by category', () {
    final result = run(const ProductQuery(categoryId: 'jeans'));
    expect(result.totalRecord, 5);
    expect(result.items!.every((p) => p.categoryId == 'jeans'), isTrue);
  });

  test('filters by tag and by sale', () {
    final newOnes = run(const ProductQuery(tag: ProductTag.newArrival));
    expect(newOnes.items!.every((p) => p.tags!.contains('newArrival')), isTrue);

    final sale = run(const ProductQuery(onSaleOnly: true, pageSize: 50));
    expect(sale.items!.every((p) => p.originalPrice != null), isTrue);
    expect(sale.totalRecord, greaterThan(0));
  });

  test('keyword matches name, brand and color, every word', () {
    expect(
      run(const ProductQuery(keyword: 'denim jacket')).items!.first.id,
      'jk1',
    );
    expect(
      run(const ProductQuery(keyword: 'Stride')).totalRecord,
      greaterThan(5),
    );
    expect(run(const ProductQuery(keyword: 'zzzz')).totalRecord, 0);
  });

  test('sorts by price both ways', () {
    final up = run(
      const ProductQuery(sort: ProductSort.priceLowToHigh, pageSize: 69),
    ).items!.map((p) => p.price!).toList();
    expect(up, [...up]..sort());

    final down = run(
      const ProductQuery(sort: ProductSort.priceHighToLow, pageSize: 69),
    ).items!.map((p) => p.price!).toList();
    expect(down, [...up.reversed]);
  });

  test('recommended order is the same on every call', () {
    final a = run(const ProductQuery()).items!.map((p) => p.id).toList();
    final b = run(const ProductQuery()).items!.map((p) => p.id).toList();
    expect(a, b);
  });

  test('price, rating, size, color and stock filters all narrow the list', () {
    final all = run(const ProductQuery(pageSize: 100)).items!;

    final cheap = run(
      const ProductQuery(minPrice: 20, maxPrice: 40, pageSize: 100),
    ).items!;
    expect(cheap, isNotEmpty);
    expect(cheap.every((p) => p.price! >= 20 && p.price! <= 40), isTrue);

    final rated = run(const ProductQuery(minRating: 4.5, pageSize: 100)).items!;
    expect(rated.every((p) => p.averageRating! >= 4.5), isTrue);
    expect(rated.length, lessThan(all.length));

    final sized = run(const ProductQuery(sizes: {'32'}, pageSize: 100)).items!;
    expect(sized, isNotEmpty);
    expect(
      sized.every(
        (p) => p.variants!.any((v) => v.size == '32' && v.stock! > 0),
      ),
      isTrue,
    );

    final black = run(
      const ProductQuery(colors: {'Black'}, pageSize: 100),
    ).items!;
    expect(black, isNotEmpty);
    expect(
      black.every(
        (p) => p.variants!.any((v) => v.colorName == 'Black' && v.stock! > 0),
      ),
      isTrue,
    );

    final inStock = run(
      const ProductQuery(inStockOnly: true, pageSize: 100),
    ).items!;
    expect(inStock.every((p) => p.variants!.any((v) => v.stock! > 0)), isTrue);
  });

  test('facets list every size and color once and the price bounds', () {
    late ProductFacetsModel facets;
    fakeAsync((async) {
      dataSource.getFacets().then((value) => facets = value);
      async.elapse(MockLatency.max);
    });
    expect(facets.sizes, containsAll(['M', '32', 'One size']));
    expect(facets.sizes!.toSet().length, facets.sizes!.length);
    final names = facets.colors!.map((c) => c.name).toList();
    expect(names.toSet().length, names.length);
    final prices = run(
      const ProductQuery(pageSize: 100),
    ).items!.map((p) => p.price!);
    expect(
      facets.minPrice,
      lessThanOrEqualTo(prices.reduce((a, b) => a < b ? a : b)),
    );
    expect(
      facets.maxPrice,
      greaterThanOrEqualTo(prices.reduce((a, b) => a > b ? a : b)),
    );
  });
}
