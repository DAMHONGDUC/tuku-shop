import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/data_sources/order_local_data_source.dart';
import 'package:tuku_shop/src/features/order/data/repositories/order_repository_impl.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  T run<T>(Future<T> Function() body) {
    late T result;
    fakeAsync((async) {
      body().then((value) => result = value);
      async.elapse(MockLatency.max * 4);
    });
    return result;
  }

  OrderRepositoryImpl repo() => OrderRepositoryImpl(
    dataSource: OrderLocalDataSourceImpl(),
    clock: () => DateTime(2026, 10, 18, 10),
  );

  const newOrder = NewOrder(
    items: [
      OrderItem(
        productId: 'wd1',
        name: 'Floral Midi Dress',
        imageUrl: 'a.jpg',
        colorName: 'Black Floral',
        size: 'S',
        unitPrice: 69,
        quantity: 1,
      ),
    ],
    shipTo: ShipTo(fullName: 'Tuku Demo', phone: '1', address: 'SF'),
    shippingMethod: 'Standard',
    shippingFee: 4.99,
    deliveryDays: 5,
    paymentMethod: 'Cash on delivery',
    subtotal: 69,
    discount: 0,
    total: 73.99,
  );

  test('the seed has twelve orders across every tab', () {
    final counts = run(repo().getOrderCounts).getOrElse(() => throw 'Left');
    expect(counts.values.fold<int>(0, (a, b) => a + b), 12);
    expect(counts[OrderStatus.delivered], 6);
    expect(counts[OrderStatus.waitingForConfirmation], 1);
  });

  test(
    'placing an order numbers it next, waits for confirmation and lists it',
    () {
      final r = repo();
      final order = run(
        () => r.placeOrder(newOrder),
      ).getOrElse(() => throw 'L');
      expect(order.id, 'TK100013');
      expect(order.status, OrderStatus.waitingForConfirmation);
      expect(order.estimatedDelivery, DateTime(2026, 10, 23, 10));

      final page = run(
        () => r.getOrders(
          const OrdersQuery(status: OrderStatus.waitingForConfirmation),
        ),
      ).getOrElse(() => throw 'L');
      expect(page.items.first.id, 'TK100013');
      expect(page.totalRecord, 2);
    },
  );

  test('only an unconfirmed order can be cancelled', () {
    final r = repo();
    final placed = run(() => r.placeOrder(newOrder)).getOrElse(() => throw 'L');
    final cancelled = run(
      () => r.cancelOrder(placed.id),
    ).getOrElse(() => throw 'L');
    expect(cancelled.status, OrderStatus.cancelled);
    expect(cancelled.events.last.status, OrderStatus.cancelled);

    expect(
      run(() => r.cancelOrder(placed.id)),
      const Left(ValidationFailure('cannot_cancel')),
    );
  });
}
