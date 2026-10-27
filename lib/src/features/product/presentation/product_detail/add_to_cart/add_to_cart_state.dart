part of 'add_to_cart_controller.dart';

enum AddToCartStatus { idle, adding, added, failed }

class AddToCartState extends Equatable {
  final AddToCartStatus status;

  /// The cart line id that was just added, for "Buy now".
  final String? lineId;
  final bool buyNow;

  const AddToCartState({
    this.status = AddToCartStatus.idle,
    this.lineId,
    this.buyNow = false,
  });

  @override
  List<Object?> get props => [status, lineId, buyNow];
}
