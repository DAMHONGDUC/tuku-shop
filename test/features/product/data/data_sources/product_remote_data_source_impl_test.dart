import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source_impl.dart';
import 'package:tuku_shop/src/features/product/data/models/product_data_model.dart';
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
}
