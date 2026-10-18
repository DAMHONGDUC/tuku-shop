import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

part 'orders_list_state.dart';

/// Orders in one status, ten at a time; reloads when an order changes.
class OrdersListController extends Cubit<OrdersListState> {
  OrdersListController(this._getOrdersUsecase, this._watchChangesUsecase)
    : super(const OrdersListState());

  final GetOrdersUsecase _getOrdersUsecase;
  final WatchOrderChangesUsecase _watchChangesUsecase;
  StreamSubscription<void>? _subscription;
  late OrderStatus _status;

  Future<void> load(OrderStatus status, {bool silent = false}) async {
    _status = status;
    _subscription ??= _watchChangesUsecase().listen(
      (_) => load(_status, silent: true),
    );
    if (!silent) emit(const OrdersListState());
    final result = await _getOrdersUsecase.call(OrdersQuery(status: status));
    if (isClosed) return;
    result.fold(
      (_) => emit(const OrdersListState(status: OrdersListStatus.error)),
      (page) => emit(
        OrdersListState(
          status: OrdersListStatus.loaded,
          items: page.items,
          page: page.currentPage,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(
      OrdersListState(
        status: state.status,
        items: state.items,
        page: state.page,
        hasMore: true,
        isLoadingMore: true,
      ),
    );
    final result = await _getOrdersUsecase.call(
      OrdersQuery(status: _status, page: state.page + 1),
    );
    if (isClosed) return;
    result.fold(
      (_) => emit(
        OrdersListState(
          status: state.status,
          items: state.items,
          page: state.page,
          hasMore: true,
        ),
      ),
      (page) => emit(
        OrdersListState(
          status: OrdersListStatus.loaded,
          items: [...state.items, ...page.items],
          page: page.currentPage,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
