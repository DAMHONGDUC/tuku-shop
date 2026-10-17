import 'package:equatable/equatable.dart';

import 'product_entity.dart';

class ProductPage extends Equatable {
  const ProductPage({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.total,
  });

  final List<ProductEntity> items;
  final int page;
  final int totalPages;
  final int total;

  bool get hasMore => page < totalPages;

  @override
  List<Object> get props => <Object>[items, page, totalPages, total];
}
