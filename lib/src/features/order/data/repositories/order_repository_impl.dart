import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/data_sources/order_local_data_source.dart';
import 'package:tuku_shop/src/features/order/data/models/order_model.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required this.dataSource, DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final OrderLocalDataSource dataSource;
  final DateTime Function() _clock;
  final _changes = StreamController<void>.broadcast();

  static OrderStatus _status(String? name) =>
      OrderStatus.values.asNameMap()[name] ?? OrderStatus.none;

  static OrderEntity _toEntity(OrderModel m) => OrderEntity(
    id: m.id ?? '',
    createdAt: DateTime.tryParse(m.createdAt ?? '') ?? DateTime(2026),
    status: _status(m.status),
    items: [
      for (final i in m.items ?? const <OrderItemModel>[])
        OrderItem(
          productId: i.productId ?? '',
          name: i.name ?? '',
          imageUrl: i.imageUrl ?? '',
          colorName: i.colorName ?? '',
          size: i.size ?? '',
          unitPrice: i.unitPrice ?? 0,
          quantity: i.quantity ?? 1,
        ),
    ],
    shipTo: ShipTo(
      fullName: m.shipToName ?? '',
      phone: m.shipToPhone ?? '',
      address: m.shipToAddress ?? '',
    ),
    shippingMethod: m.shippingMethod ?? '',
    shippingFee: m.shippingFee ?? 0,
    paymentMethod: m.paymentMethod ?? '',
    subtotal: m.subtotal ?? 0,
    discount: m.discount ?? 0,
    total: m.total ?? 0,
    voucherCode: m.voucherCode,
    estimatedDelivery:
        DateTime.tryParse(m.estimatedDelivery ?? '') ?? DateTime(2026),
    events: [
      for (final e in m.events ?? const <OrderEventModel>[])
        OrderEvent(
          status: _status(e.status),
          at: DateTime.tryParse(e.at ?? '') ?? DateTime(2026),
        ),
    ],
  );

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Right(await run());
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Stream<void> watchChanges() => _changes.stream;

  @override
  Future<Either<Failure, OrdersPage>> getOrders(OrdersQuery query) =>
      _guard(() async {
        final matched = (await dataSource.getAll())
            .where((o) => _status(o.status) == query.status)
            .toList();
        final total = matched.length;
        final start = (query.page - 1) * query.pageSize;
        final end = (start + query.pageSize).clamp(0, total);
        return OrdersPage(
          items: start < total
              ? matched.sublist(start, end).map(_toEntity).toList()
              : const [],
          currentPage: query.page,
          totalPage: total == 0 ? 0 : (total / query.pageSize).ceil(),
          totalRecord: total,
        );
      });

  @override
  Future<Either<Failure, OrderEntity>> getOrderDetail(String orderId) =>
      _guard(() async {
        final order = (await dataSource.getAll()).firstWhereOrNull(
          (o) => o.id == orderId,
        );
        if (order == null) throw const ValidationException('not_found');
        return _toEntity(order);
      });

  @override
  Future<Either<Failure, Map<OrderStatus, int>>> getOrderCounts() =>
      _guard(() async {
        final counts = {for (final s in OrderStatusExt.tabs) s: 0};
        for (final o in await dataSource.getAll()) {
          final status = _status(o.status);
          counts[status] = (counts[status] ?? 0) + 1;
        }
        return counts;
      });

  @override
  Future<Either<Failure, OrderEntity>> placeOrder(NewOrder order) =>
      _guard(() async {
        final now = _clock();
        final stored = await dataSource.insert(
          OrderModel(
            createdAt: now.toIso8601String(),
            status: OrderStatus.waitingForConfirmation.name,
            items: [
              for (final i in order.items)
                OrderItemModel(
                  productId: i.productId,
                  name: i.name,
                  imageUrl: i.imageUrl,
                  colorName: i.colorName,
                  size: i.size,
                  unitPrice: i.unitPrice,
                  quantity: i.quantity,
                ),
            ],
            shipToName: order.shipTo.fullName,
            shipToPhone: order.shipTo.phone,
            shipToAddress: order.shipTo.address,
            shippingMethod: order.shippingMethod,
            shippingFee: order.shippingFee,
            paymentMethod: order.paymentMethod,
            subtotal: order.subtotal,
            discount: order.discount,
            total: order.total,
            voucherCode: order.voucherCode,
            estimatedDelivery: now
                .add(Duration(days: order.deliveryDays))
                .toIso8601String(),
            events: [
              OrderEventModel(
                status: OrderStatus.waitingForConfirmation.name,
                at: now.toIso8601String(),
              ),
            ],
          ),
        );
        _changes.add(null);
        return _toEntity(stored);
      });

  @override
  Future<Either<Failure, OrderEntity>> cancelOrder(String orderId) =>
      _guard(() async {
        final cancelled = await dataSource.update(orderId, (order) {
          if (_status(order.status) != OrderStatus.waitingForConfirmation) {
            throw const ValidationException('cannot_cancel');
          }
          return order.copyWith(
            status: OrderStatus.cancelled.name,
            events: [
              ...?order.events,
              OrderEventModel(
                status: OrderStatus.cancelled.name,
                at: _clock().toIso8601String(),
              ),
            ],
          );
        });
        _changes.add(null);
        return _toEntity(cancelled);
      });

  @override
  Future<Either<Failure, Unit>> reset() => _guard(() async {
    await dataSource.reset();
    _changes.add(null);
    return unit;
  });
}
