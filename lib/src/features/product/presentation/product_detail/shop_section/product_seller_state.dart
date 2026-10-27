part of 'product_seller_controller.dart';

enum ProductSellerStatus { loading, loaded, error }

class ProductSellerState extends Equatable {
  final ProductSellerStatus status;
  final Seller? seller;

  const ProductSellerState({
    this.status = ProductSellerStatus.loading,
    this.seller,
  });

  @override
  List<Object?> get props => [status, seller];
}
