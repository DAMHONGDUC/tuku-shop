import 'package:tuku_shop/src/features/cart/domain/entities/cart_line.dart';

/// Totals derived from the cart lines.
class CartSummary {
  const CartSummary(this.lines);

  final List<CartLine> lines;

  /// Orders at or above this ship free with standard shipping.
  static const freeShippingThreshold = 100.0;

  int get itemCount => lines.fold(0, (sum, l) => sum + l.quantity);

  double get subtotal => lines.fold(0, (sum, l) => sum + l.total);

  /// What the original prices would have cost minus what is paid.
  double get savings => lines.fold(
    0,
    (sum, l) =>
        sum +
        ((l.originalPrice ?? l.unitPrice) - l.unitPrice).clamp(
              0,
              double.infinity,
            ) *
            l.quantity,
  );

  bool get qualifiesForFreeShipping => subtotal >= freeShippingThreshold;

  double get amountToFreeShipping =>
      (freeShippingThreshold - subtotal).clamp(0, freeShippingThreshold);
}
