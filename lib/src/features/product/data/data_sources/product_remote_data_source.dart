import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_page_model.dart';
import 'package:tuku_shop/src/features/product/data/models/reviews_page_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

abstract class ProductRemoteDataSource {
  Future<ProductPageModel> getProducts(ProductQuery query);

  Future<ProductModel> getProductDetail(String id);

  Future<List<ProductModel>> getProductsByIds(List<String> ids);

  Future<List<ProductModel>> getRelatedProducts(String id);

  Future<({DateTime endsAt, List<ProductModel> products})> getFlashSale();

  Future<ReviewsPageModel> getReviews({
    required String productId,
    required int page,
  });

  Future<List<String>> getTrendingSearches();
}
