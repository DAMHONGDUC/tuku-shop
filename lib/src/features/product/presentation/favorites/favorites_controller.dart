import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

part 'favorites_state.dart';

/// Which products carry a filled heart, app-wide. Toggles show at once and
/// roll back if saving fails.
class FavoritesController extends Cubit<FavoritesState> {
  FavoritesController(
    this._getWishlistIdsUsecase,
    this._watchWishlistIdsUsecase,
    this._toggleWishlistUsecase,
  ) : super(const FavoritesState()) {
    _subscription = _watchWishlistIdsUsecase().listen(
      (ids) => emit(FavoritesState(ids: ids.toSet(), failureCount: _failures)),
    );
  }

  final GetWishlistIdsUsecase _getWishlistIdsUsecase;
  final WatchWishlistIdsUsecase _watchWishlistIdsUsecase;
  final ToggleWishlistUsecase _toggleWishlistUsecase;
  late final StreamSubscription<List<String>> _subscription;
  int _failures = 0;

  Future<void> load() async {
    final result = await _getWishlistIdsUsecase.call(NoParams());
    result.fold(
      (_) {},
      (ids) => emit(FavoritesState(ids: ids.toSet(), failureCount: _failures)),
    );
  }

  Future<void> toggle(String productId) async {
    final before = state.ids;
    final optimistic = before.contains(productId)
        ? ({...before}..remove(productId))
        : {...before, productId};
    emit(FavoritesState(ids: optimistic, failureCount: _failures));

    final result = await _toggleWishlistUsecase.call(productId);
    result.fold((_) {
      _failures++;
      emit(FavoritesState(ids: before, failureCount: _failures));
    }, (_) {});
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
