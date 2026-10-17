import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

/// The bag, shared by the tab bar badge, the product page and the bag tab.
class CartController extends Cubit<CartEntity> {
  CartController({
    required WatchCartUsecase watchCart,
    required this._addToCart,
    required this._updateQuantity,
    required this._removeItem,
    required this._applyPromo,
    required this._removePromo,
    required this._clearCart,
  }) : super(const CartEntity()) {
    _subscription = watchCart(const NoParams()).listen(emit);
  }

  final AddToCartUsecase _addToCart;
  final UpdateCartQuantityUsecase _updateQuantity;
  final RemoveCartItemUsecase _removeItem;
  final ApplyPromoUsecase _applyPromo;
  final RemovePromoUsecase _removePromo;
  final ClearCartUsecase _clearCart;
  late final StreamSubscription<CartEntity> _subscription;

  Future<bool> add(AddToCartParams params) async =>
      (await _addToCart(params)).isRight();

  Future<void> updateQuantity(String itemId, int quantity) => _updateQuantity(
    UpdateCartQuantityParams(itemId: itemId, quantity: quantity),
  );

  Future<void> remove(String itemId) => _removeItem(itemId);

  /// Null on success, the failure otherwise.
  Future<Failure?> applyPromo(String code) async {
    final Either<Failure, CartEntity> result = await _applyPromo(code);
    return result.fold((Failure f) => f, (CartEntity _) => null);
  }

  Future<void> removePromo() => _removePromo(const NoParams());

  Future<void> clear() => _clearCart(const NoParams());

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
