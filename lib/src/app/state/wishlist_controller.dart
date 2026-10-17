import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

/// The saved product ids, so every heart on every card agrees.
class WishlistController extends Cubit<List<String>> {
  WishlistController({
    required WatchWishlistUsecase watchWishlist,
    required ToggleWishlistUsecase toggleWishlist,
  }) : _toggle = toggleWishlist,
       super(const <String>[]) {
    _subscription = watchWishlist(const NoParams()).listen(emit);
  }

  final ToggleWishlistUsecase _toggle;
  late final StreamSubscription<List<String>> _subscription;

  bool contains(String productId) => state.contains(productId);

  /// Returns whether the product is now saved, or null if it failed.
  Future<bool?> toggle(String productId) async {
    final Either<Failure, bool> result = await _toggle(productId);
    return result.fold((Failure _) => null, (bool saved) => saved);
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
