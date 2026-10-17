import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import 'cart_item_entity.dart';
import 'promo_entity.dart';

/// The bag and everything derived from it. Totals live here so the bag, the
/// checkout and the order all add up the same way.
class CartEntity extends Equatable {
  const CartEntity({this.items = const <CartItemEntity>[], this.promo});

  static const double standardShipping = 6.99;

  final List<CartItemEntity> items;
  final PromoEntity? promo;

  bool get isEmpty => items.isEmpty;

  int get itemCount => items.map((CartItemEntity i) => i.quantity).sum;

  double get subtotal => items.map((CartItemEntity i) => i.lineTotal).sum;

  /// What the markdowns saved, compared with full price.
  double get savings => items
      .map(
        (CartItemEntity i) => i.compareAtPrice == null
            ? 0.0
            : (i.compareAtPrice! - i.unitPrice) * i.quantity,
      )
      .sum;

  double get discount => promo == null
      ? 0
      : double.parse((subtotal * promo!.percentOff).toStringAsFixed(2));

  bool get qualifiesForFreeShipping =>
      subtotal >= AppConstants.freeShippingThreshold ||
      (promo?.freeShipping ?? false);

  /// How much more until shipping is free; zero once it is.
  double get amountToFreeShipping => qualifiesForFreeShipping
      ? 0
      : AppConstants.freeShippingThreshold - subtotal;

  double get estimatedShipping =>
      isEmpty || qualifiesForFreeShipping ? 0 : standardShipping;

  double get total => subtotal - discount + estimatedShipping;

  CartEntity copyWith({
    List<CartItemEntity>? items,
    PromoEntity? Function()? promo,
  }) => CartEntity(
    items: items ?? this.items,
    promo: promo == null ? this.promo : promo(),
  );

  @override
  List<Object?> get props => <Object?>[items, promo];
}
