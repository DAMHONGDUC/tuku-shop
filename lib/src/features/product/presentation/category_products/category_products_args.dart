import 'package:tuku_shop/src/features/product/domain/domain.dart';

class CategoryProductsArgs {
  const CategoryProductsArgs({
    required this.title,
    this.categoryId,
    this.tag,
    this.sellerId,
    this.onSaleOnly = false,
  });

  final String title;
  final String? categoryId;
  final ProductTag? tag;

  /// A shop page: only this seller's listings.
  final String? sellerId;
  final bool onSaleOnly;

  ProductQuery get query => ProductQuery(
    categoryId: categoryId,
    tag: tag,
    sellerId: sellerId,
    onSaleOnly: onSaleOnly,
  );

  factory CategoryProductsArgs.fromQuery(Map<String, String> query) =>
      CategoryProductsArgs(
        title: query['title'] ?? '',
        categoryId: query['categoryId'],
        tag: ProductTag.values.asNameMap()[query['tag']],
        sellerId: query['seller'],
        onSaleOnly: query['sale'] == '1',
      );
}
