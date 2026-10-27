import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

part 'cart_state.dart';

/// The cart, app-wide: the tab, the nav badge and checkout all read it.
/// Quantity changes and removals show at once and roll back on failure.
class CartController extends Cubit<CartState> {
  CartController(
    this._getCartUsecase,
    this._watchCartUsecase,
    this._updateQuantityUsecase,
    this._removeLineUsecase,
    this._addToCartUsecase,
  ) : super(const CartState()) {
    _subscription = _watchCartUsecase().listen(
      (lines) => emit(state.copyWith(status: CartStatus.loaded, lines: lines)),
    );
  }

  final GetCartUsecase _getCartUsecase;
  final WatchCartUsecase _watchCartUsecase;
  final UpdateCartQuantityUsecase _updateQuantityUsecase;
  final RemoveCartLineUsecase _removeLineUsecase;
  final AddToCartUsecase _addToCartUsecase;
  late final StreamSubscription<List<CartLine>> _subscription;

  Future<void> load() async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await _getCartUsecase.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(status: CartStatus.error)),
      (lines) => emit(state.copyWith(status: CartStatus.loaded, lines: lines)),
    );
  }

  Future<void> changeQuantity(String lineId, int quantity) async {
    final line = state.lines.where((l) => l.id == lineId).firstOrNull;
    if (line == null || quantity == line.quantity) return;
    if (quantity < 1) {
      await remove(lineId);
      return;
    }
    if (quantity > line.maxQuantity) return;

    await _optimistic(
      [
        for (final l in state.lines)
          l.id == lineId ? l.copyWith(quantity: quantity) : l,
      ],
      () => _updateQuantityUsecase.call(
        UpdateCartQuantityParams(lineId: lineId, quantity: quantity),
      ),
    );
  }

  /// Removes the line; returns it so the screen can offer Undo.
  Future<CartLine?> remove(String lineId) async {
    final line = state.lines.where((l) => l.id == lineId).firstOrNull;
    if (line == null) return null;
    await _optimistic(
      state.lines.where((l) => l.id != lineId).toList(),
      () => _removeLineUsecase.call(lineId),
    );
    return line;
  }

  Future<void> undoRemove(CartLine line) async {
    await _optimistic([
      line,
      ...state.lines,
    ], () => _addToCartUsecase.call(line));
  }

  Future<void> _optimistic(
    List<CartLine> next,
    Future<Either<Failure, List<CartLine>>> Function() run,
  ) async {
    final before = state.lines;
    emit(state.copyWith(lines: next));
    final result = await run();
    result.fold(
      (_) => emit(
        state.copyWith(lines: before, failureCount: state.failureCount + 1),
      ),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
