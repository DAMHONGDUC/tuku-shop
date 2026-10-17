import 'package:tuku_shop/src/features/order/data/models/order_model.dart';

/// Past orders for the demo account, dated relative to [now] so the history
/// always looks recent.
abstract final class OrderMock {
  static const String _p = 'assets/images/product/';
  static const String _address =
      '742 Valencia Street, Apt 3B, San Francisco, CA 94110, United States';

  static List<TrackingEventModel> trackingFor(String status, DateTime placed) {
    const List<(String, String)> path = <(String, String)>[
      ('placed', 'Order received'),
      ('processing', 'Tuku Fulfilment Centre, Oakland CA'),
      ('shipped', 'Handed to carrier, Oakland CA'),
      ('outForDelivery', 'Local depot, San Francisco CA'),
      ('delivered', 'Left at front door'),
    ];
    final int reached = status == 'cancelled'
        ? 0
        : path.indexWhere(((String, String) p) => p.$1 == status);

    return <TrackingEventModel>[
      for (int i = 0; i <= reached; i++)
        TrackingEventModel(
          status: path[i].$1,
          time: placed.add(Duration(hours: i * 19 + i * i * 3)),
          location: path[i].$2,
        ),
      if (status == 'cancelled')
        TrackingEventModel(
          status: 'cancelled',
          time: placed.add(const Duration(hours: 2)),
          location: 'Cancelled at your request',
        ),
    ];
  }

  static List<OrderModel> seed(DateTime now) {
    OrderModel order({
      required String id,
      required String code,
      required int daysAgo,
      required String status,
      required List<OrderItemModel> items,
      String payment = 'Visa •••• 4242',
      String paymentType = 'card',
      String delivery = 'standard',
      double shipping = 0,
      double discount = 0,
      String? promo,
    }) {
      final DateTime placed = now.subtract(Duration(days: daysAgo, hours: 3));
      final double subtotal = items.fold(
        0,
        (double sum, OrderItemModel i) =>
            sum + (i.unitPrice ?? 0) * (i.quantity ?? 1),
      );

      return OrderModel(
        id: id,
        code: code,
        createdAt: placed,
        status: status,
        items: items,
        recipient: 'Alex Morgan',
        phone: '+1 (415) 555-0132',
        address: _address,
        paymentType: paymentType,
        paymentLabel: payment,
        deliveryOptionId: delivery,
        subtotal: subtotal,
        shippingFee: shipping,
        discount: discount,
        promoCode: promo,
        estimatedDelivery: placed.add(const Duration(days: 5)),
        tracking: trackingFor(status, placed),
      );
    }

    return <OrderModel>[
      order(
        id: 'o_1048',
        code: 'TK-261048',
        daysAgo: 1,
        status: 'processing',
        delivery: 'express',
        shipping: 14.99,
        items: const <OrderItemModel>[
          OrderItemModel(
            productId: 'wh02',
            name: 'Hera Pullover Hoodie',
            image: '${_p}wh02_blue_0.webp',
            color: 'Blue',
            size: 'M',
            quantity: 1,
            unitPrice: 33.99,
          ),
          OrderItemModel(
            productId: 'wsh01',
            name: 'Fiona Fitness Short',
            image: '${_p}wsh01_black_0.webp',
            color: 'Black',
            size: '29',
            quantity: 2,
            unitPrice: 29.00,
          ),
        ],
      ),
      order(
        id: 'o_1031',
        code: 'TK-261031',
        daysAgo: 4,
        status: 'shipped',
        items: const <OrderItemModel>[
          OrderItemModel(
            productId: 'mj01',
            name: 'Beaumont Summit Kit',
            image: '${_p}mj01_orange_0.webp',
            color: 'Orange',
            size: 'L',
            quantity: 1,
            unitPrice: 41.99,
          ),
          OrderItemModel(
            productId: 'ms09',
            name: 'Ryker LumaTech™ Tee (Crew-neck)',
            image: '${_p}ms09_black_0.webp',
            color: 'Black',
            size: 'L',
            quantity: 1,
            unitPrice: 32.00,
          ),
          OrderItemModel(
            productId: '24-mb04',
            name: 'Strive Shoulder Pack',
            image: '${_p}24-mb04_default_0.webp',
            color: 'Black',
            size: 'One Size',
            quantity: 1,
            unitPrice: 32.00,
          ),
        ],
        promo: 'TUKU10',
        discount: 10.60,
      ),
      order(
        id: 'o_1027',
        code: 'TK-261027',
        daysAgo: 6,
        status: 'outForDelivery',
        payment: 'Apple Pay',
        paymentType: 'applePay',
        items: const <OrderItemModel>[
          OrderItemModel(
            productId: 'wb01',
            name: 'Electra Bra Top',
            image: '${_p}wb01_purple_0.webp',
            color: 'Purple',
            size: 'S',
            quantity: 1,
            unitPrice: 29.25,
          ),
          OrderItemModel(
            productId: 'wp02',
            name: 'Emma Leggings',
            image: '${_p}wp02_blue_0.webp',
            color: 'Blue',
            size: '28',
            quantity: 1,
            unitPrice: 42.00,
          ),
          OrderItemModel(
            productId: 'ws04',
            name: 'Layla Tee',
            image: '${_p}ws04_green_0.webp',
            color: 'Green',
            size: 'S',
            quantity: 1,
            unitPrice: 29.00,
          ),
        ],
      ),
      order(
        id: 'o_0996',
        code: 'TK-260996',
        daysAgo: 18,
        status: 'delivered',
        items: const <OrderItemModel>[
          OrderItemModel(
            productId: 'mh03',
            name: 'Bruno Compete Hoodie',
            image: '${_p}mh03_black_0.webp',
            color: 'Black',
            size: 'M',
            quantity: 1,
            unitPrice: 63.00,
          ),
        ],
        shipping: 6.99,
      ),
      order(
        id: 'o_0951',
        code: 'TK-260951',
        daysAgo: 37,
        status: 'delivered',
        payment: 'PayPal',
        paymentType: 'paypal',
        items: const <OrderItemModel>[
          OrderItemModel(
            productId: 'wj04',
            name: 'Ingrid Running Jacket',
            image: '${_p}wj04_white_0.webp',
            color: 'White',
            size: 'S',
            quantity: 1,
            unitPrice: 84.00,
          ),
          OrderItemModel(
            productId: 'wsh03',
            name: 'Gwen Drawstring Bike Short',
            image: '${_p}wsh03_gray_0.webp',
            color: 'Gray',
            size: '28',
            quantity: 1,
            unitPrice: 50.00,
          ),
        ],
      ),
      order(
        id: 'o_0920',
        code: 'TK-260920',
        daysAgo: 52,
        status: 'cancelled',
        items: const <OrderItemModel>[
          OrderItemModel(
            productId: 'mp03',
            name: 'Geo Insulated Jogging Pant',
            image: '${_p}mp03_blue_0.webp',
            color: 'Blue',
            size: '32',
            quantity: 1,
            unitPrice: 51.00,
          ),
        ],
        shipping: 6.99,
      ),
    ];
  }
}
