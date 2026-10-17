import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

part 'wishlist_state.dart';

/// Saved products. Follows the saved ids, so a heart tapped anywhere in the
/// app updates this list.
class WishlistController extends Cubit<WishlistState> {
  WishlistController(
    this._getWishlistIdsUsecase,
    this._watchWishlistIdsUsecase,
    this._toggleWishlistUsecase,
    this._getProductsByIdsUsecase,
  ) : super(const WishlistState()) {
    _subscription = _watchWishlistIdsUsecase().listen(_showIds);
  }

  final GetWishlistIdsUsecase _getWishlistIdsUsecase;
  final WatchWishlistIdsUsecase _watchWishlistIdsUsecase;
  final ToggleWishlistUsecase _toggleWishlistUsecase;
  final GetProductsByIdsUsecase _getProductsByIdsUsecase;
  late final StreamSubscription<List<String>> _subscription;

  Future<void> load() async {
    emit(const WishlistState());
    final result = await _getWishlistIdsUsecase.call(NoParams());
    await result.fold(
      (_) async => emit(const WishlistState(status: WishlistStatus.error)),
      _showIds,
    );
  }

  Future<void> _showIds(List<String> ids) async {
    // Drop removed items at once; fetch only ids not on screen yet.
    final known = {for (final p in state.products) p.id: p};
    final missing = ids.where((id) => !known.containsKey(id)).toList();
    if (missing.isEmpty) {
      emit(
        WishlistState(
          status: WishlistStatus.loaded,
          products: [for (final id in ids) ?known[id]],
        ),
      );
      return;
    }
    final result = await _getProductsByIdsUsecase.call(missing);
    if (isClosed) return;
    result.fold(
      (_) => emit(const WishlistState(status: WishlistStatus.error)),
      (fetched) {
        final all = {...known, for (final p in fetched) p.id: p};
        emit(
          WishlistState(
            status: WishlistStatus.loaded,
            products: [for (final id in ids) ?all[id]],
          ),
        );
      },
    );
  }

  Future<void> remove(String productId) async {
    final before = state.products;
    emit(
      WishlistState(
        status: WishlistStatus.loaded,
        products: before.where((p) => p.id != productId).toList(),
      ),
    );
    final result = await _toggleWishlistUsecase.call(productId);
    result.fold(
      (_) =>
          emit(WishlistState(status: WishlistStatus.loaded, products: before)),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
