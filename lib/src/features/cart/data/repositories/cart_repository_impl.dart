import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:tuku_shop/src/features/cart/data/mapper/promo_model_to_promo_entity_mapper.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

/// The bag lives in memory for the session, like a guest cart would.
class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required this.remote, CartEntity? initial})
    : _cart = initial ?? const CartEntity();

  final CartRemoteDataSource remote;

  static const String _tag = 'CartRepository';

  final StreamController<CartEntity> _changes =
      StreamController<CartEntity>.broadcast();
  CartEntity _cart;

  Either<Failure, CartEntity> _set(CartEntity next) {
    // A promo whose minimum the bag no longer meets falls away.
    final PromoEntity? promo = next.promo;
    _cart = promo != null && next.subtotal < promo.minSubtotal
        ? next.copyWith(promo: () => null)
        : next;
    _changes.add(_cart);
    return Right<Failure, CartEntity>(_cart);
  }

  @override
  Stream<CartEntity> watch() async* {
    yield _cart;
    yield* _changes.stream;
  }

  @override
  Future<Either<Failure, CartEntity>> add(CartItemEntity item) async {
    await MockLatency.short();

    final int index = _cart.items.indexWhere(
      (CartItemEntity i) => i.id == item.id,
    );
    final List<CartItemEntity> items = List<CartItemEntity>.of(_cart.items);

    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + item.quantity,
      );
    } else {
      items.insert(0, item);
    }

    SdLogger.action(_tag, 'Added', item.id);
    return _set(_cart.copyWith(items: items));
  }

  @override
  Future<Either<Failure, CartEntity>> updateQuantity(
    String itemId,
    int quantity,
  ) async => _set(
    _cart.copyWith(
      items: _cart.items
          .map(
            (CartItemEntity i) =>
                i.id == itemId ? i.copyWith(quantity: quantity) : i,
          )
          .toList(),
    ),
  );

  @override
  Future<Either<Failure, CartEntity>> remove(String itemId) async {
    SdLogger.action(_tag, 'Removed', itemId);
    return _set(
      _cart.copyWith(
        items: _cart.items.where((CartItemEntity i) => i.id != itemId).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, CartEntity>> applyPromo(String code) async {
    try {
      final PromoEntity promo = PromoModelToPromoEntityMapper.toEntity(
        await remote.redeem(code, subtotal: _cart.subtotal),
      );
      SdLogger.action(_tag, 'Promo applied', code);
      return _set(_cart.copyWith(promo: () => promo));
    } on ValidationException catch (e) {
      return Left<Failure, CartEntity>(ValidationFailure(e.code));
    } catch (e, stackTrace) {
      SdLogger.error(_tag, 'Promo failed', error: e, stackTrace: stackTrace);
      return const Left<Failure, CartEntity>(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CartEntity>> removePromo() async =>
      _set(_cart.copyWith(promo: () => null));

  @override
  Future<Either<Failure, CartEntity>> clear() async => _set(const CartEntity());
}
