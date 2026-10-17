import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

part 'orders_state.dart';

class OrdersController extends Cubit<OrdersState> {
  OrdersController(this._getOrders) : super(const OrdersState());

  final GetOrdersUsecase _getOrders;

  Future<void> load() async {
    final Either<Failure, List<OrderEntity>> result = await _getOrders(
      const NoParams(),
    );
    result.fold(
      (Failure _) => emit(state.copyWith(status: LoadStatus.failure)),
      (List<OrderEntity> o) => emit(state.copyWith(status: LoadStatus.success, orders: o)),
    );
  }

  void setFilter(OrdersFilter filter) => emit(state.copyWith(filter: filter));
}
