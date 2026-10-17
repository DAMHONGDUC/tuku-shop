import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:tuku_shop/src/features/order/data/repositories/order_repository_impl.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

void main() {
  final DateTime now = DateTime(2026, 10, 17, 10);
  late OrderRepositoryImpl repository;

  setUpAll(() => MockLatency.enabled = false);

  setUp(() {
    DateTime clock() => now;
    repository = OrderRepositoryImpl(
      dataSource: OrderRemoteDataSourceImpl(clock: clock),
      clock: clock,
    );
  });

  OrderEntity right(Either<Failure, OrderEntity> result) =>
      result.getOrElse(() => throw StateError('expected Right, got $result'));

  PlaceOrderParams params() => const PlaceOrderParams(
    items: <OrderItemEntity>[
      OrderItemEntity(
        productId: 'p_1',
        name: 'Tee',
        image: 'tee.webp',
        color: 'Black',
        size: 'M',
        quantity: 2,
        unitPrice: 20,
      ),
    ],
    recipient: 'Alex Morgan',
    phone: '+1 415 555 0132',
    address: '1 Market St, San Francisco',
    paymentType: PaymentMethodType.card,
    paymentLabel: 'Visa 4242',
    deliveryOptionId: 'standard',
    deliveryMaxDays: 5,
    subtotal: 40,
    shippingFee: 6.99,
    discount: 0,
  );

  test('getOrders returns the history newest first', () async {
    final List<OrderEntity> orders = (await repository.getOrders()).getOrElse(
      () => <OrderEntity>[],
    );

    expect(orders, isNotEmpty);
    for (int i = 1; i < orders.length; i++) {
      expect(orders[i - 1].createdAt.isBefore(orders[i].createdAt), isFalse);
    }
  });

  test(
    'placeOrder stores a placed order that shows first in the history',
    () async {
      final OrderEntity placed = right(await repository.placeOrder(params()));

      expect(placed.status, OrderStatus.placed);
      expect(placed.estimatedDelivery, now.add(const Duration(days: 5)));
      expect(placed.items.single.quantity, 2);

      final List<OrderEntity> orders = (await repository.getOrders()).getOrElse(
        () => <OrderEntity>[],
      );
      expect(orders.first.id, placed.id);
    },
  );

  test('cancelOrder cancels an order that has not shipped', () async {
    final OrderEntity placed = right(await repository.placeOrder(params()));

    final OrderEntity cancelled = right(
      await repository.cancelOrder(placed.id),
    );

    expect(cancelled.status, OrderStatus.cancelled);
    expect(cancelled.tracking.last.status, OrderStatus.cancelled);
  });

  test('a delivered order cannot be cancelled', () async {
    final List<OrderEntity> orders = (await repository.getOrders()).getOrElse(
      () => <OrderEntity>[],
    );
    final OrderEntity delivered = orders.firstWhere(
      (OrderEntity o) => o.status == OrderStatus.delivered,
    );

    expect(
      await repository.cancelOrder(delivered.id),
      const Left<Failure, OrderEntity>(
        ValidationFailure(FailureCodes.notCancellable),
      ),
    );
  });

  test('an unknown id fails with a server failure', () async {
    expect(
      await repository.getOrder('missing'),
      const Left<Failure, OrderEntity>(ServerFailure()),
    );
  });
}
