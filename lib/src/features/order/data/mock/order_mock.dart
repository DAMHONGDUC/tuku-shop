import 'dart:math';

import 'package:tuku_shop/src/features/order/data/models/order_model.dart';

const _kCatalogPath = 'assets/images/catalog/';

/// Products as the order service saw them at purchase time. Ids match the
/// catalog so an order can link back to its product.
class _ProductSnapshot {
  final String id;
  final String name;
  final double price;
  final List<({String name, String code, String imageUrl})> colors;

  const _ProductSnapshot({
    required this.id,
    required this.name,
    required this.price,
    required this.colors,
  });
}

class OrderMock {
  // Fixed seed: the same orders on every launch.
  static final _random = Random(42);
  static var _nextOrderNumber = 100001;

  static const _sizes = ['S', 'M', 'L', 'XL'];

  static const _products = [
    _ProductSnapshot(
      id: 'wd1',
      name: 'Floral Midi Dress',
      price: 69.00,
      colors: [
        (
          name: 'Black Floral',
          code: '#2B2B2B',
          imageUrl: '${_kCatalogPath}women-dresses/wd1_1.jpg',
        ),
        (
          name: 'Cream Floral',
          code: '#F3E9DC',
          imageUrl: '${_kCatalogPath}women-dresses/wd1_2.jpg',
        ),
      ],
    ),
    _ProductSnapshot(
      id: 'mt1',
      name: 'Essential Crew Tee',
      price: 19.90,
      colors: [
        (
          name: 'White',
          code: '#FAFAFA',
          imageUrl: '${_kCatalogPath}men-tshirts/mt1_1.jpg',
        ),
      ],
    ),
    _ProductSnapshot(
      id: 'jn1',
      name: 'Slim Fit Jeans',
      price: 59.00,
      colors: [
        (
          name: 'Light Wash',
          code: '#9DB4D0',
          imageUrl: '${_kCatalogPath}jeans/jn1_1.jpg',
        ),
        (
          name: 'Mid Wash',
          code: '#5D7DA8',
          imageUrl: '${_kCatalogPath}jeans/jn1_2.jpg',
        ),
      ],
    ),
    _ProductSnapshot(
      id: 'jk1',
      name: 'Classic Denim Jacket',
      price: 89.00,
      colors: [
        (
          name: 'Indigo',
          code: '#2E3A59',
          imageUrl: '${_kCatalogPath}jackets/jk1_1.jpg',
        ),
      ],
    ),
    _ProductSnapshot(
      id: 'hd1',
      name: 'Classic Pullover Hoodie',
      price: 54.00,
      colors: [
        (
          name: 'Black',
          code: '#1C1C1C',
          imageUrl: '${_kCatalogPath}hoodies/hd1_1.jpg',
        ),
      ],
    ),
  ];

  static T _pick<T>(List<T> items) => items[_random.nextInt(items.length)];

  static OrderModel generateOrderMockItem() {
    final product = _pick(_products);
    final color = _pick(product.colors);
    final quantity = 1 + _random.nextInt(3);

    return OrderModel(
      id: 'TK${_nextOrderNumber++}',
      productName: product.name,
      productId: product.id,
      quantity: quantity,
      totalPrice: product.price * quantity,
      productThumbnailUrl: color.imageUrl,
      colorName: color.name,
      colorCode: color.code,
      sizeName: _pick(_sizes),
    );
  }

  static List<OrderModel> generateOrders({int count = 10}) {
    return List.generate(count, (_) => generateOrderMockItem());
  }
}
