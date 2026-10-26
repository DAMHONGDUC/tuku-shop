import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

import '../../../helpers/mock_repositories.dart';

void main() {
  CartLine line(double price, int qty, {double? was}) => CartLine(
    productId: 'p$price',
    name: 'n',
    brand: 'b',
    imageUrl: 'a.jpg',
    colorName: 'c',
    size: 'M',
    unitPrice: price,
    originalPrice: was,
    quantity: qty,
    maxQuantity: 10,
  );

  test('totals, savings and the free-shipping gap', () {
    final summary = CartSummary([line(30, 2), line(20, 1, was: 25)]);
    expect(summary.itemCount, 3);
    expect(summary.subtotal, 80);
    expect(summary.savings, 5);
    expect(summary.qualifiesForFreeShipping, isFalse);
    expect(summary.amountToFreeShipping, 20);
    expect(summary.freeShippingProgress, 0.8);
  });

  test('free-shipping progress stops at 1 past the threshold', () {
    expect(CartSummary([line(60, 2)]).freeShippingProgress, 1);
    expect(const CartSummary([]).freeShippingProgress, 0);
  });

  test('AddToCartUsecase rejects a quantity above stock', () async {
    final repo = MockCartRepository();
    final result = await AddToCartUsecase(repo).call(line(10, 11));
    expect(result, const Left(ValidationFailure('invalid_quantity')));
  });
}
