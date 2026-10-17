import 'package:equatable/equatable.dart';

import 'product_entity.dart';

class FlashSaleEntity extends Equatable {
  const FlashSaleEntity({required this.endsAt, required this.products});

  final DateTime endsAt;
  final List<ProductEntity> products;

  @override
  List<Object> get props => <Object>[endsAt, products];
}
