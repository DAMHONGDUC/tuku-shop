import 'product_model.dart';

class ProductPageModel {
  const ProductPageModel({
    this.items,
    this.page,
    this.totalPages,
    this.total,
  });

  final List<ProductModel>? items;
  final int? page;
  final int? totalPages;
  final int? total;
}
