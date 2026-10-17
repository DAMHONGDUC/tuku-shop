import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'variant_selection_state.dart';

/// The color, size and quantity picked on the product page.
class VariantSelectionController extends Cubit<VariantSelectionState> {
  VariantSelectionController() : super(const VariantSelectionState());

  void init(ProductEntity product) {
    // Start on the first color that has anything in stock.
    final color =
        product.productColors.firstWhereOrNull(
          (c) => product.variants.any(
            (v) => v.colorName == c.colorName && v.stock > 0,
          ),
        ) ??
        product.productColors.firstOrNull;
    // A one-size product has nothing to choose.
    final onlySize = product.productSizes.length == 1
        ? product.productSizes.first.name
        : null;

    emit(
      VariantSelectionState(
        product: product,
        colorName: color?.colorName,
        size: onlySize,
      ),
    );
  }

  void selectColor(String colorName) {
    final next = state.copyWith(colorName: colorName, quantity: 1);
    // Keep the size only if it is still in stock in the new color.
    final keepSize = next.size != null && next.isSizeAvailable(next.size!);
    emit(keepSize ? next : next.copyWith(clearSize: true));
  }

  void selectSize(String size) {
    if (!state.isSizeAvailable(size)) return;
    emit(state.copyWith(size: size, quantity: 1));
  }

  void increment() {
    if (state.quantity < state.maxQuantity) {
      emit(state.copyWith(quantity: state.quantity + 1));
    }
  }

  void decrement() {
    if (state.quantity > 1) emit(state.copyWith(quantity: state.quantity - 1));
  }
}
