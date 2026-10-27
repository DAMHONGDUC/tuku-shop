part of 'wishlist_controller.dart';

enum WishlistStatus { loading, loaded, error }

class WishlistState extends Equatable {
  final WishlistStatus status;
  final List<ProductEntity> products;

  const WishlistState({
    this.status = WishlistStatus.loading,
    this.products = const [],
  });

  @override
  List<Object?> get props => [status, products];
}
