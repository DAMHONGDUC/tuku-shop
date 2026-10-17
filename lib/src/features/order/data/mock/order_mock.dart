import 'dart:math';

import 'package:tuku_shop/src/features/order/data/models/order_model.dart';

const _kMockProductPath = 'assets/images/product/';

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

  static const _sizes = ['S', 'M', 'L', 'XL', 'XXL'];

  static const _products = [
    _ProductSnapshot(
      id: '1',
      name: 'Margaux Leather',
      price: 195.00,
      colors: [
        (
          name: 'Onyx',
          code: '#2C2C2C',
          imageUrl: '${_kMockProductPath}p1_1.png',
        ),
        (
          name: 'Orche',
          code: '#DAA520',
          imageUrl: '${_kMockProductPath}p1_2.png',
        ),
        (
          name: 'Mocha',
          code: '#8B4513',
          imageUrl: '${_kMockProductPath}p1_4.png',
        ),
      ],
    ),
    _ProductSnapshot(
      id: '2',
      name: 'Vancouver Crossbody',
      price: 143.45,
      colors: [
        (
          name: 'Onyx',
          code: '#2C2C2C',
          imageUrl: '${_kMockProductPath}p2_1.png',
        ),
        (
          name: 'Orche',
          code: '#DAA520',
          imageUrl: '${_kMockProductPath}p2_2.png',
        ),
      ],
    ),
    _ProductSnapshot(
      id: '3',
      name: 'Shoulder Bag Beach',
      price: 195.00,
      colors: [
        (
          name: 'Onyx',
          code: '#2C2C2C',
          imageUrl: '${_kMockProductPath}p3_1.png',
        ),
      ],
    ),
    _ProductSnapshot(
      id: '4',
      name: 'Everyday Leather',
      price: 143.45,
      colors: [
        (
          name: 'Onyx',
          code: '#2C2C2C',
          imageUrl: '${_kMockProductPath}p4_1.png',
        ),
        (
          name: 'Burgundy',
          code: '#800020',
          imageUrl: '${_kMockProductPath}p4_2.png',
        ),
        (
          name: 'Navy',
          code: '#1F2937',
          imageUrl: '${_kMockProductPath}p4_3.png',
        ),
      ],
    ),
    _ProductSnapshot(
      id: '6',
      name: 'Melanie Suede',
      price: 143.45,
      colors: [
        (
          name: 'Brown',
          code: '#8B4513',
          imageUrl: '${_kMockProductPath}p6_1.png',
        ),
        (
          name: 'Light Brown',
          code: '#D2B48C',
          imageUrl: '${_kMockProductPath}p6_2.png',
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
