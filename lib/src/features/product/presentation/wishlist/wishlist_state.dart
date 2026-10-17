part of 'wishlist_controller.dart';

class WishlistScreenState extends Equatable {
  const WishlistScreenState({
    this.status = LoadStatus.loading,
    this.products = const <ProductEntity>[],
  });

  final LoadStatus status;
  final List<ProductEntity> products;

  WishlistScreenState copyWith({
    LoadStatus? status,
    List<ProductEntity>? products,
  }) => WishlistScreenState(
    status: status ?? this.status,
    products: products ?? this.products,
  );

  @override
  List<Object> get props => <Object>[status, products];
}
