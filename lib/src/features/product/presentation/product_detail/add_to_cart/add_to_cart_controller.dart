import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'add_to_cart_state.dart';

/// Puts the picked variant into the cart.
class AddToCartController extends Cubit<AddToCartState> {
  AddToCartController(this._addToCartUsecase) : super(const AddToCartState());

  final AddToCartUsecase _addToCartUsecase;

  Future<void> add({
    required ProductEntity product,
    required String colorName,
    required String size,
    required int quantity,
    bool buyNow = false,
  }) async {
    if (state.status == AddToCartStatus.adding) return;

    final stock = product.stockFor(colorName: colorName, size: size);
    final image =
        product.productColors
            .where((c) => c.colorName == colorName)
            .firstOrNull
            ?.imageUrl ??
        product.imageUrl;
    final line = CartLine(
      productId: product.id,
      name: product.name,
      brand: product.brand,
      imageUrl: image,
      colorName: colorName,
      size: size,
      unitPrice: product.price,
      originalPrice: product.originalPrice,
      quantity: quantity,
      maxQuantity: stock.clamp(1, 10),
    );

    emit(AddToCartState(status: AddToCartStatus.adding, buyNow: buyNow));
    final result = await _addToCartUsecase.call(line);
    result.fold(
      (_) =>
          emit(AddToCartState(status: AddToCartStatus.failed, buyNow: buyNow)),
      (_) => emit(
        AddToCartState(
          status: AddToCartStatus.added,
          lineId: line.id,
          buyNow: buyNow,
        ),
      ),
    );
  }
}
