import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

/// The bag, shared by the tab bar badge, the product page and the bag tab.
class CartController extends Cubit<CartEntity> {
  CartController({
    required WatchCartUsecase watchCart,
    required AddToCartUsecase addToCart,
    required UpdateCartQuantityUsecase updateQuantity,
    required RemoveCartItemUsecase removeItem,
    required ApplyPromoUsecase applyPromo,
    required RemovePromoUsecase removePromo,
    required ClearCartUsecase clearCart,
  }) : _addToCart = addToCart,
       _updateQuantity = updateQuantity,
       _removeItem = removeItem,
       _applyPromo = applyPromo,
       _removePromo = removePromo,
       _clearCart = clearCart,
       super(const CartEntity()) {
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

  /// Restores a line removed by mistake — the bag's undo.
  Future<void> restore(CartItemEntity item) => _addToCart(
    AddToCartParams(
      productId: item.productId,
      name: item.name,
      brand: item.brand,
      image: item.image,
      color: item.color,
      size: item.size,
      unitPrice: item.unitPrice,
      compareAtPrice: item.compareAtPrice,
      quantity: item.quantity,
    ),
  );

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
