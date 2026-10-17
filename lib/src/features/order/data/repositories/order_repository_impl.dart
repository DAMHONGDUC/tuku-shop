import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:tuku_shop/src/features/order/data/mapper/order_model_to_order_entity_mapper.dart';
import 'package:tuku_shop/src/features/order/data/models/order_model.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl({
    required this.dataSource,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final OrderRemoteDataSource dataSource;
  final DateTime Function() _clock;

  static const String _tag = 'OrderRepository';

  Future<Either<Failure, T>> _guard<T>(
    String action,
    Future<T> Function() run,
  ) async {
    try {
      return Right<Failure, T>(await run());
    } on ValidationException catch (e) {
      return Left<Failure, T>(ValidationFailure(e.code));
    } catch (e, stackTrace) {
      SdLogger.error(_tag, action, error: e, stackTrace: stackTrace);
      return Left<Failure, T>(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() => _guard(
    'Load orders failed',
    () async => (await dataSource.getOrders())
        .map(OrderModelToOrderEntityMapper.toEntity)
        .toList(),
  );

  @override
  Future<Either<Failure, OrderEntity>> getOrder(String id) => _guard(
    'Load order failed',
    () async =>
        OrderModelToOrderEntityMapper.toEntity(await dataSource.getOrder(id)),
  );

  @override
  Future<Either<Failure, OrderEntity>> placeOrder(PlaceOrderParams params) =>
      _guard('Place order failed', () async {
        final OrderModel placed = await dataSource.placeOrder(
          OrderModel(
            items: params.items
                .map(OrderModelToOrderEntityMapper.itemToModel)
                .toList(),
            recipient: params.recipient,
            phone: params.phone,
            address: params.address,
            paymentType: params.paymentType.name,
            paymentLabel: params.paymentLabel,
            deliveryOptionId: params.deliveryOptionId,
            subtotal: params.subtotal,
            shippingFee: params.shippingFee,
            discount: params.discount,
            promoCode: params.promoCode,
            estimatedDelivery: _clock().add(
              Duration(days: params.deliveryMaxDays),
            ),
          ),
        );
        SdLogger.action(_tag, 'Placed', placed.code);
        return OrderModelToOrderEntityMapper.toEntity(placed);
      });

  @override
  Future<Either<Failure, OrderEntity>> cancelOrder(String id) =>
      _guard('Cancel order failed', () async {
        final OrderModel cancelled = await dataSource.cancelOrder(id);
        SdLogger.action(_tag, 'Cancelled', cancelled.code);
        return OrderModelToOrderEntityMapper.toEntity(cancelled);
      });
}
