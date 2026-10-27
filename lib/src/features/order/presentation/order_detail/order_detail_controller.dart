import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

part 'order_detail_state.dart';

class OrderDetailController extends Cubit<OrderDetailState> {
  OrderDetailController(
    this._getOrderDetailUsecase,
    this._cancelOrderUsecase,
    this._addToCartUsecase,
    this._addNotificationUsecase,
  ) : super(const OrderDetailState());

  final GetOrderDetailUsecase _getOrderDetailUsecase;
  final CancelOrderUsecase _cancelOrderUsecase;
  final AddToCartUsecase _addToCartUsecase;
  final AddNotificationUsecase _addNotificationUsecase;

  Future<void> load(String orderId) async {
    emit(const OrderDetailState());
    final result = await _getOrderDetailUsecase.call(orderId);
    result.fold(
      (_) => emit(const OrderDetailState(status: OrderDetailStatus.error)),
      (order) => emit(
        OrderDetailState(status: OrderDetailStatus.loaded, order: order),
      ),
    );
  }

  Future<void> cancel() async {
    final order = state.order;
    if (order == null || !order.canCancel) return;
    emit(state.copyWith(action: OrderAction.cancelling));
    final result = await _cancelOrderUsecase.call(order.id);
    await result.fold(
      (_) async => emit(state.copyWith(action: OrderAction.cancelFailed)),
      (cancelled) async {
        await _addNotificationUsecase.call(
          NewNotification(
            title: 'Order cancelled',
            body: 'Order #${cancelled.id} was cancelled. No charge was made.',
            type: NotificationType.orderUpdate,
            relatedItemId: cancelled.id,
          ),
        );
        emit(state.copyWith(order: cancelled, action: OrderAction.cancelled));
      },
    );
  }

  /// Puts every item back in the cart.
  Future<void> buyAgain() async {
    final order = state.order;
    if (order == null) return;
    emit(state.copyWith(action: OrderAction.reordering));
    for (final item in order.items) {
      final result = await _addToCartUsecase.call(
        CartLine(
          productId: item.productId,
          name: item.name,
          brand: '',
          imageUrl: item.imageUrl,
          colorName: item.colorName,
          size: item.size,
          unitPrice: item.unitPrice,
          quantity: item.quantity.clamp(1, 10),
          maxQuantity: 10,
        ),
      );
      if (result.isLeft()) {
        emit(state.copyWith(action: OrderAction.reorderFailed));
        return;
      }
    }
    emit(state.copyWith(action: OrderAction.reordered));
  }
}
