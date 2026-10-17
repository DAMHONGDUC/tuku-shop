import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

import '../../../../helpers/fixtures.dart';

void main() {
  group('CartEntity', () {
    test('an empty bag costs nothing, shipping included', () {
      const CartEntity cart = CartEntity();

      expect(cart.subtotal, 0);
      expect(cart.estimatedShipping, 0);
      expect(cart.total, 0);
      expect(cart.itemCount, 0);
    });

    test('subtotal and item count add up every line', () {
      final CartEntity cart = CartEntity(
        items: <CartItemEntity>[
          Fixtures.cartItem(unitPrice: 20, quantity: 2),
          Fixtures.cartItem(productId: 'p_2', unitPrice: 15),
        ],
      );

      expect(cart.subtotal, 55);
      expect(cart.itemCount, 3);
    });

    test('savings compare each marked-down line with its full price', () {
      final CartEntity cart = CartEntity(
        items: <CartItemEntity>[
          Fixtures.cartItem(unitPrice: 30, compareAtPrice: 40, quantity: 2),
          Fixtures.cartItem(productId: 'p_2', unitPrice: 10),
        ],
      );

      expect(cart.savings, 20);
    });

    test('below the threshold shipping is charged and the gap is shown', () {
      final CartEntity cart = CartEntity(
        items: <CartItemEntity>[Fixtures.cartItem(unitPrice: 50)],
      );

      expect(cart.qualifiesForFreeShipping, isFalse);
      expect(cart.estimatedShipping, CartEntity.standardShipping);
      expect(
        cart.amountToFreeShipping,
        AppConstants.freeShippingThreshold - 50,
      );
      expect(cart.total, 50 + CartEntity.standardShipping);
    });

    test('at the threshold shipping is free', () {
      final CartEntity cart = CartEntity(
        items: <CartItemEntity>[
          Fixtures.cartItem(unitPrice: AppConstants.freeShippingThreshold),
        ],
      );

      expect(cart.estimatedShipping, 0);
      expect(cart.amountToFreeShipping, 0);
    });

    test('a percent-off promo discounts the subtotal, rounded to cents', () {
      final CartEntity cart = CartEntity(
        items: <CartItemEntity>[Fixtures.cartItem(unitPrice: 33.33)],
        promo: const PromoEntity(code: 'TUKU10', percentOff: 0.1),
      );

      expect(cart.discount, 3.33);
      expect(
        cart.total,
        closeTo(33.33 - 3.33 + CartEntity.standardShipping, 0.001),
      );
    });

    test('a free-shipping promo waives shipping below the threshold', () {
      final CartEntity cart = CartEntity(
        items: <CartItemEntity>[Fixtures.cartItem(unitPrice: 10)],
        promo: const PromoEntity(code: 'FREESHIP', freeShipping: true),
      );

      expect(cart.discount, 0);
      expect(cart.estimatedShipping, 0);
      expect(cart.amountToFreeShipping, 0);
    });
  });
}
