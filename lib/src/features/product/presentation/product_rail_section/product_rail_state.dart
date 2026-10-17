part of 'product_rail_controller.dart';

class ProductRailState extends Equatable {
  const ProductRailState({
    this.status = LoadStatus.loading,
    this.products = const <ProductEntity>[],
  });

  final LoadStatus status;
  final List<ProductEntity> products;

  @override
  List<Object> get props => <Object>[status, products];
}
