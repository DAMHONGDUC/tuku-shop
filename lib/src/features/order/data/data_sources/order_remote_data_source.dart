import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/mock/order_mock.dart';
import 'package:tuku_shop/src/features/order/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();

  Future<OrderModel> getOrder(String id);

  Future<OrderModel> placeOrder(OrderModel order);

  Future<OrderModel> cancelOrder(String id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl({DateTime Function()? clock})
    : _clock = clock ?? DateTime.now {
    _orders = OrderMock.seed(_clock());
  }

  final DateTime Function() _clock;
  late List<OrderModel> _orders;
  int _sequence = 1049;

  @override
  Future<List<OrderModel>> getOrders() async {
    await MockLatency.normal();

    return List<OrderModel>.of(_orders)..sort(
      (OrderModel a, OrderModel b) =>
          (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)),
    );
  }

  @override
  Future<OrderModel> getOrder(String id) async {
    await MockLatency.short();

    final OrderModel? order = _orders.firstWhereOrNull(
      (OrderModel o) => o.id == id,
    );

    if (order == null) throw ServerException('Order $id not found');
    return order;
  }

  @override
  Future<OrderModel> placeOrder(OrderModel order) async {
    await MockLatency.long();

    final DateTime now = _clock();
    final int number = _sequence++;
    final OrderModel placed = OrderModel(
      id: 'o_$number',
      code: 'TK-26$number',
      createdAt: now,
      status: 'placed',
      items: order.items,
      recipient: order.recipient,
      phone: order.phone,
      address: order.address,
      paymentType: order.paymentType,
      paymentLabel: order.paymentLabel,
      deliveryOptionId: order.deliveryOptionId,
      subtotal: order.subtotal,
      shippingFee: order.shippingFee,
      discount: order.discount,
      promoCode: order.promoCode,
      estimatedDelivery: order.estimatedDelivery,
      tracking: OrderMock.trackingFor('placed', now),
    );

    _orders = <OrderModel>[placed, ..._orders];
    return placed;
  }

  @override
  Future<OrderModel> cancelOrder(String id) async {
    await MockLatency.normal();

    final int index = _orders.indexWhere((OrderModel o) => o.id == id);

    if (index < 0) throw ServerException('Order $id not found');

    final OrderModel order = _orders[index];

    if (order.status != 'placed' && order.status != 'processing') {
      throw const ValidationException(FailureCodes.notCancellable);
    }

    final OrderModel cancelled = order.copyWith(
      status: 'cancelled',
      tracking: <TrackingEventModel>[
        ...?order.tracking,
        TrackingEventModel(
          status: 'cancelled',
          time: _clock(),
          location: 'Cancelled at your request',
        ),
      ],
    );
    _orders[index] = cancelled;
    return cancelled;
  }
}
