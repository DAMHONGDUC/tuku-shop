import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

part 'order_detail_state.dart';

class OrderDetailController extends Cubit<OrderDetailState> {
  OrderDetailController({
    required this._getOrder,
    required this._cancelOrder,
    required this._addToCart,
  }) : super(const OrderDetailState());

  final GetOrderDetailUsecase _getOrder;
  final CancelOrderUsecase _cancelOrder;
  final AddToCartUsecase _addToCart;

  Future<void> load(String id) async {
    final Either<Failure, OrderEntity> result = await _getOrder(id);
    result.fold(
      (Failure _) => emit(const OrderDetailState(status: LoadStatus.failure)),
      (OrderEntity o) =>
          emit(OrderDetailState(status: LoadStatus.success, order: o)),
    );
  }

  Future<bool> cancel() async {
    final OrderEntity? order = state.order;

    if (order == null) return false;

    emit(state.copyWith(busy: true));

    final Either<Failure, OrderEntity> result = await _cancelOrder(order.id);

    return result.fold(
      (Failure _) {
        emit(state.copyWith(busy: false));
        return false;
      },
      (OrderEntity o) {
        emit(OrderDetailState(status: LoadStatus.success, order: o));
        return true;
      },
    );
  }

  /// Puts every line of the order back in the bag.
  Future<void> buyAgain() async {
    final OrderEntity? order = state.order;

    if (order == null) return;

    emit(state.copyWith(busy: true));

    for (final OrderItemEntity i in order.items) {
      await _addToCart(
        AddToCartParams(
          productId: i.productId,
          name: i.name,
          brand: '',
          image: i.image,
          color: i.color,
          size: i.size,
          unitPrice: i.unitPrice,
          quantity: i.quantity,
        ),
      );
    }

    emit(state.copyWith(busy: false));
  }
}
