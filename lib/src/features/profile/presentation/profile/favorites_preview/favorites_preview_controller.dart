import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

part 'favorites_preview_state.dart';

/// The Favorites card on Profile: the total and the first few saved
/// products. Follows the saved ids, so a heart tapped anywhere updates it.
class FavoritesPreviewController extends Cubit<FavoritesPreviewState> {
  FavoritesPreviewController(
    this._getWishlistIdsUsecase,
    this._watchWishlistIdsUsecase,
    this._getProductsByIdsUsecase,
  ) : super(const FavoritesPreviewState()) {
    _subscription = _watchWishlistIdsUsecase().listen(_showIds);
  }

  /// How many products the card shows.
  static const limit = 6;

  final GetWishlistIdsUsecase _getWishlistIdsUsecase;
  final WatchWishlistIdsUsecase _watchWishlistIdsUsecase;
  final GetProductsByIdsUsecase _getProductsByIdsUsecase;
  late final StreamSubscription<List<String>> _subscription;

  Future<void> load() async {
    emit(state.copyWith(status: FavoritesPreviewStatus.loading));
    final result = await _getWishlistIdsUsecase.call(NoParams());
    await result.fold(
      (_) async => emit(state.copyWith(status: FavoritesPreviewStatus.error)),
      _showIds,
    );
  }

  Future<void> _showIds(List<String> ids) async {
    // Reuse products already on screen; fetch only the new ids.
    final shown = ids.take(limit).toList();
    final known = {for (final p in state.products) p.id: p};
    final missing = shown.where((id) => !known.containsKey(id)).toList();
    if (missing.isEmpty) {
      emit(
        FavoritesPreviewState(
          status: FavoritesPreviewStatus.loaded,
          products: [for (final id in shown) ?known[id]],
          total: ids.length,
        ),
      );
      return;
    }
    final result = await _getProductsByIdsUsecase.call(missing);
    if (isClosed) return;
    result.fold(
      (_) => emit(state.copyWith(status: FavoritesPreviewStatus.error)),
      (fetched) {
        final all = {...known, for (final p in fetched) p.id: p};
        emit(
          FavoritesPreviewState(
            status: FavoritesPreviewStatus.loaded,
            products: [for (final id in shown) ?all[id]],
            total: ids.length,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
