import 'dart:math';

import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/models/order_model.dart';

const _kCatalogPath = 'assets/images/catalog/';

/// Twelve past orders across every status, generated with a fixed seed so
/// the demo history is the same on every install.
class OrderMock {
  static const firstOrderNumber = 100001;

  static const _products = [
    OrderItemModel(
      productId: 'wd1',
      name: 'Floral Midi Dress',
      imageUrl: '${_kCatalogPath}women-dresses/wd1_1.jpg',
      colorName: 'Black Floral',
      unitPrice: 69,
    ),
    OrderItemModel(
      productId: 'mt1',
      name: 'Essential Crew Tee',
      imageUrl: '${_kCatalogPath}men-tshirts/mt1_1.jpg',
      colorName: 'White',
      unitPrice: 19.9,
    ),
    OrderItemModel(
      productId: 'jn1',
      name: 'Slim Fit Jeans',
      imageUrl: '${_kCatalogPath}jeans/jn1_1.jpg',
      colorName: 'Light Wash',
      unitPrice: 59,
    ),
    OrderItemModel(
      productId: 'jk1',
      name: 'Classic Denim Jacket',
      imageUrl: '${_kCatalogPath}jackets/jk1_1.jpg',
      colorName: 'Indigo',
      unitPrice: 89,
    ),
    OrderItemModel(
      productId: 'hd1',
      name: 'Classic Pullover Hoodie',
      imageUrl: '${_kCatalogPath}hoodies/hd1_1.jpg',
      colorName: 'Black',
      unitPrice: 54,
    ),
    OrderItemModel(
      productId: 'sh1',
      name: 'White Leather Sneakers',
      imageUrl: '${_kCatalogPath}shoes/sh1_1.jpg',
      colorName: 'White',
      unitPrice: 89,
    ),
    OrderItemModel(
      productId: 'bg1',
      name: 'Leather Tote',
      imageUrl: '${_kCatalogPath}bags/bg1_1.jpg',
      colorName: 'Cognac',
      unitPrice: 129,
    ),
    OrderItemModel(
      productId: 'as2',
      name: 'Classic Cap',
      imageUrl: '${_kCatalogPath}accessories/as2_1.jpg',
      colorName: 'White',
      unitPrice: 24,
    ),
  ];

  static const _sizes = ['S', 'M', 'L'];

  /// Newest first: one waiting, one to ship, two on the way, six delivered,
  /// one cancelled, one returned.
  static const _statuses = [
    OrderStatus.waitingForConfirmation,
    OrderStatus.waitingForPickup,
    OrderStatus.waitingForDelivery,
    OrderStatus.waitingForDelivery,
    OrderStatus.delivered,
    OrderStatus.cancelled,
    OrderStatus.delivered,
    OrderStatus.delivered,
    OrderStatus.rolledBack,
    OrderStatus.delivered,
    OrderStatus.delivered,
    OrderStatus.delivered,
  ];

  /// The path an order takes to reach [status].
  static List<OrderStatus> pathTo(OrderStatus status) => switch (status) {
    OrderStatus.waitingForConfirmation => [OrderStatus.waitingForConfirmation],
    OrderStatus.waitingForPickup => [
      OrderStatus.waitingForConfirmation,
      OrderStatus.waitingForPickup,
    ],
    OrderStatus.waitingForDelivery => [
      OrderStatus.waitingForConfirmation,
      OrderStatus.waitingForPickup,
      OrderStatus.waitingForDelivery,
    ],
    OrderStatus.delivered => [
      OrderStatus.waitingForConfirmation,
      OrderStatus.waitingForPickup,
      OrderStatus.waitingForDelivery,
      OrderStatus.delivered,
    ],
    OrderStatus.rolledBack => [
      OrderStatus.waitingForConfirmation,
      OrderStatus.waitingForPickup,
      OrderStatus.waitingForDelivery,
      OrderStatus.delivered,
      OrderStatus.rolledBack,
    ],
    OrderStatus.cancelled => [
      OrderStatus.waitingForConfirmation,
      OrderStatus.cancelled,
    ],
    OrderStatus.none => const [],
  };

  static List<OrderModel> seed({DateTime? now}) {
    final random = Random(42);
    final today = now ?? DateTime.now();

    return [
      for (var i = 0; i < _statuses.length; i++)
        () {
          final status = _statuses[i];
          final created = DateTime(
            today.year,
            today.month,
            today.day,
            9 + random.nextInt(10),
            random.nextInt(60),
          ).subtract(Duration(days: i * 4 + 1));
          final lineCount = 1 + random.nextInt(2);
          final items = [
            for (var l = 0; l < lineCount; l++)
              () {
                final p = _products[(i + l * 3) % _products.length];
                return OrderItemModel(
                  productId: p.productId,
                  name: p.name,
                  imageUrl: p.imageUrl,
                  colorName: p.colorName,
                  size: _sizes[random.nextInt(_sizes.length)],
                  unitPrice: p.unitPrice,
                  quantity: 1 + random.nextInt(2),
                );
              }(),
          ];
          final subtotal = items.fold<double>(
            0,
            (s, e) => s + e.unitPrice! * e.quantity!,
          );
          final shippingFee = subtotal >= 100 ? 0.0 : 4.99;
          final path = pathTo(status);

          return OrderModel(
            id: 'TK${firstOrderNumber + _statuses.length - 1 - i}',
            createdAt: created.toIso8601String(),
            status: status.name,
            items: items,
            shipToName: 'Tuku Demo',
            shipToPhone: '+1 202 555 0147',
            shipToAddress: '1600 Market St, Apt 12, San Francisco, CA 94103',
            shippingMethod: 'Standard',
            shippingFee: shippingFee,
            paymentMethod: i.isEven ? 'Cash on delivery' : 'Card (demo)',
            subtotal: subtotal,
            discount: 0,
            total: subtotal + shippingFee,
            estimatedDelivery: created
                .add(const Duration(days: 5))
                .toIso8601String(),
            events: [
              for (var e = 0; e < path.length; e++)
                OrderEventModel(
                  status: path[e].name,
                  at: created
                      .add(Duration(hours: e * 20 + (e > 0 ? 3 : 0)))
                      .toIso8601String(),
                ),
            ],
          );
        }(),
    ];
  }
}
