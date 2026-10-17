import 'package:tuku_shop/src/features/cart/domain/domain.dart';

/// What the bag holds on a fresh launch, so the demo opens on a lived-in
/// store rather than an empty one.
abstract final class CartMock {
  static const CartEntity seed = CartEntity(
    items: <CartItemEntity>[
      CartItemEntity(
        id: 'wj02|Black|S',
        productId: 'wj02',
        name: 'Josie Yoga Jacket',
        brand: 'Tuku Outdoor',
        image: 'assets/images/product/wj02_black_0.webp',
        color: 'Black',
        size: 'S',
        unitPrice: 38.99,
        compareAtPrice: 56.25,
        quantity: 1,
      ),
      CartItemEntity(
        id: 'ms05|Blue|M',
        productId: 'ms05',
        name: 'Helios EverCool™ Tee',
        brand: 'Tuku Essentials',
        image: 'assets/images/product/ms05_blue_0.webp',
        color: 'Blue',
        size: 'M',
        unitPrice: 24.00,
        quantity: 2,
      ),
    ],
  );
}
