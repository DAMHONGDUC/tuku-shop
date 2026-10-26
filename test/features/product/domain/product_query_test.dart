import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

void main() {
  test('withFilters replaces every filter, keeps keyword and sort', () {
    const start = ProductQuery(
      keyword: 'dress',
      categoryId: 'jeans',
      onSaleOnly: true,
      sort: ProductSort.newest,
      page: 3,
    );
    final next = start.withFilters(
      const ProductFilters(minRating: 4, colors: {'Black'}),
    );

    expect(next.keyword, 'dress');
    expect(next.sort, ProductSort.newest);
    expect(next.page, 1);
    expect(next.categoryId, isNull);
    expect(next.onSaleOnly, isFalse);
    expect(next.filters, const ProductFilters(minRating: 4, colors: {'Black'}));
  });

  test('activeCount counts filter groups, price as one', () {
    expect(const ProductFilters().activeCount, 0);
    expect(
      const ProductFilters(
        minPrice: 10,
        maxPrice: 50,
        sizes: {'S', 'M'},
        inStockOnly: true,
      ).activeCount,
      3,
    );
  });
}
