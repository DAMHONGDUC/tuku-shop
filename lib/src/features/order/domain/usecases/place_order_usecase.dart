import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/order_entity.dart';
import '../entities/order_item_entity.dart';
import '../repositories/order_repository.dart';

class PlaceOrderParams extends Equatable {
  const PlaceOrderParams({
    required this.items,
    required this.recipient,
    required this.phone,
    required this.address,
    required this.paymentType,
    required this.paymentLabel,
    required this.deliveryOptionId,
    required this.deliveryMaxDays,
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
    this.promoCode,
  });

  final List<OrderItemEntity> items;
  final String recipient;
  final String phone;
  final String address;
  final PaymentMethodType paymentType;
  final String paymentLabel;
  final String deliveryOptionId;
  final int deliveryMaxDays;
  final double subtotal;
  final double shippingFee;
  final double discount;
  final String? promoCode;

  @override
  List<Object?> get props => <Object?>[
    items,
    recipient,
    phone,
    address,
    paymentType,
    paymentLabel,
    deliveryOptionId,
    deliveryMaxDays,
    subtotal,
    shippingFee,
    discount,
    promoCode,
  ];
}

class PlaceOrderUsecase implements UseCase<OrderEntity, PlaceOrderParams> {
  PlaceOrderUsecase(this.repository);

  final OrderRepository repository;

  @override
  Future<Either<Failure, OrderEntity>> call(PlaceOrderParams params) {
    if (params.items.isEmpty) {
      return Future<Either<Failure, OrderEntity>>.value(
        const Left<Failure, OrderEntity>(
          ValidationFailure(FailureCodes.emptyCart),
        ),
      );
    }

    return repository.placeOrder(params);
  }
}
