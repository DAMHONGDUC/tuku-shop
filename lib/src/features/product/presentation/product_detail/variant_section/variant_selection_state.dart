part of 'variant_selection_controller.dart';

class VariantSelectionState extends Equatable {
  final ProductEntity? product;
  final String? colorName;
  final String? size;
  final int quantity;

  const VariantSelectionState({
    this.product,
    this.colorName,
    this.size,
    this.quantity = 1,
  });

  /// Stock of the selected color × size; null until a size is picked.
  int? get stock => product == null || colorName == null || size == null
      ? null
      : product!.stockFor(colorName: colorName!, size: size!);

  bool isSizeAvailable(String size) => product == null || colorName == null
      ? true
      : product!.stockFor(colorName: colorName!, size: size) > 0;

  bool get canAddToCart => size != null && (stock ?? 0) >= quantity;

  /// Highest quantity allowed for one cart line.
  int get maxQuantity => (stock ?? 10).clamp(1, 10);

  VariantSelectionState copyWith({
    ProductEntity? product,
    String? colorName,
    String? size,
    bool clearSize = false,
    int? quantity,
  }) {
    return VariantSelectionState(
      product: product ?? this.product,
      colorName: colorName ?? this.colorName,
      size: clearSize ? null : (size ?? this.size),
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, colorName, size, quantity];
}
