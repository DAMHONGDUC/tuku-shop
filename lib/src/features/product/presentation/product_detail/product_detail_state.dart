part of 'product_detail_controller.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.status = LoadStatus.loading,
    this.product,
    this.colorIndex = 0,
    this.size,
    this.quantity = 1,
    this.related = const <ProductEntity>[],
    this.reviews,
    this.adding = false,
    this.sizeNudge = 0,
    this.addedCount = 0,
  });

  final LoadStatus status;
  final ProductEntity? product;
  final int colorIndex;
  final String? size;
  final int quantity;
  final List<ProductEntity> related;
  final ReviewsPage? reviews;
  final bool adding;

  /// Bumped each time "Add to bag" is pressed without a size.
  final int sizeNudge;

  /// Bumped on each successful add, so the button can celebrate.
  final int addedCount;

  ProductColor? get color =>
      product == null || product!.colors.isEmpty ? null : product!.colors[colorIndex];

  List<String> get images => color?.images ?? const <String>[];

  ProductDetailState copyWith({
    int? colorIndex,
    String? Function()? size,
    int? quantity,
    List<ProductEntity>? related,
    ReviewsPage? Function()? reviews,
    bool? adding,
    int? sizeNudge,
    int? addedCount,
  }) => ProductDetailState(
    status: status,
    product: product,
    colorIndex: colorIndex ?? this.colorIndex,
    size: size == null ? this.size : size(),
    quantity: quantity ?? this.quantity,
    related: related ?? this.related,
    reviews: reviews == null ? this.reviews : reviews(),
    adding: adding ?? this.adding,
    sizeNudge: sizeNudge ?? this.sizeNudge,
    addedCount: addedCount ?? this.addedCount,
  );

  @override
  List<Object?> get props => <Object?>[
    status,
    product,
    colorIndex,
    size,
    quantity,
    related,
    reviews,
    adding,
    sizeNudge,
    addedCount,
  ];
}
