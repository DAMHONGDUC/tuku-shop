import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

part 'order_success_state.dart';

class OrderSuccessController extends Cubit<OrderSuccessState> {
  OrderSuccessController(this._getOrder) : super(const OrderSuccessState());

  final GetOrderDetailUsecase _getOrder;

  Future<void> load(String id) async {
    final Either<Failure, OrderEntity> result = await _getOrder(id);
    result.fold(
      (Failure _) => emit(const OrderSuccessState(status: LoadStatus.failure)),
      (OrderEntity o) =>
          emit(OrderSuccessState(status: LoadStatus.success, order: o)),
    );
  }
}
