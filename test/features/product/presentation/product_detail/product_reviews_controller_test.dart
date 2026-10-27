import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/reviews_section/product_reviews_controller.dart';

import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetProductReviewsUsecase usecase;

  setUpAll(
    () => registerFallbackValue(const ProductReviewsParams(productId: 'p')),
  );

  setUp(() {
    usecase = MockGetProductReviewsUsecase();
    when(() => usecase.call(any())).thenAnswer(
      (_) async => const Right(
        ReviewsPage(items: [], currentPage: 1, totalPage: 3, totalRecord: 24),
      ),
    );
  });

  test('the product page previews 3; load more keeps that page size', () async {
    final c = ProductReviewsController(usecase);
    await c.load('p', pageSize: ProductReviewsController.previewSize);
    await c.loadMore();

    final sent = verify(
      () => usecase.call(captureAny()),
    ).captured.cast<ProductReviewsParams>();
    expect(sent.map((p) => p.pageSize), [3, 3]);
    expect(sent.last.page, 2);
    await c.close();
  });

  test('All reviews pages 10 at a time by default', () async {
    final c = ProductReviewsController(usecase);
    await c.load('p');
    final sent =
        verify(() => usecase.call(captureAny())).captured.single
            as ProductReviewsParams;
    expect(sent.pageSize, 10);
    await c.close();
  });

  test('color and size filters combine and toggle off', () async {
    final c = ProductReviewsController(usecase);
    await c.load('p');
    await c.toggleColor('Black');
    await c.toggleSize('M');
    expect(c.state.colorFilter, 'Black');
    expect(c.state.sizeFilter, 'M');

    await c.toggleColor('Black');
    expect(c.state.colorFilter, isNull);
    expect(c.state.sizeFilter, 'M');

    final sent = verify(
      () => usecase.call(captureAny()),
    ).captured.cast<ProductReviewsParams>();
    expect(sent.map((p) => (p.colorName, p.size)), [
      (null, null),
      ('Black', null),
      ('Black', 'M'),
      (null, 'M'),
    ]);
    expect(sent.every((p) => p.page == 1), isTrue);

    await c.clearFilter();
    expect(c.state.isFiltered, isFalse);
    await c.close();
  });
}
