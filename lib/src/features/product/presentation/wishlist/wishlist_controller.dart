import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'wishlist_state.dart';

/// Turns the saved ids into products for the wishlist tab. The ids come from
/// the app-wide wishlist; this only looks them up in the catalogue.
class WishlistScreenController extends Cubit<WishlistScreenState> {
  WishlistScreenController(this._getProductsByIds)
    : super(const WishlistScreenState());

  final GetProductsByIdsUsecase _getProductsByIds;

  Future<void> sync(List<String> ids) async {
    final List<String> known = state.products.map((ProductEntity p) => p.id).toList();

    // Removing an item needs no round trip: drop it in place so the grid
    // animates rather than reloads.
    if (state.status == LoadStatus.success && ids.every(known.contains)) {
      emit(
        state.copyWith(
          products: state.products.where((ProductEntity p) => ids.contains(p.id)).toList(),
        ),
      );
      return;
    }

    if (state.products.isEmpty) emit(state.copyWith(status: LoadStatus.loading));

    final Either<Failure, List<ProductEntity>> result = await _getProductsByIds(ids);

    result.fold(
      (Failure _) => emit(state.copyWith(status: LoadStatus.failure)),
      (List<ProductEntity> products) => emit(
        WishlistScreenState(
          status: LoadStatus.success,
          products: ids
              .map((String id) => products.firstWhereOrNull((ProductEntity p) => p.id == id))
              .whereType<ProductEntity>()
              .toList(),
        ),
      ),
    );
  }
}
