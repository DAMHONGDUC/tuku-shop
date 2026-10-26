import 'package:tuku_shop/src/features/product/data/models/product_data_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_facets_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/reviews_page_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsDataModel> getProducts(ProductQuery query);

  Future<ProductModel> getProductDetail({required String productId});

  Future<List<ProductModel>> getRelatedProducts({
    required String productId,
    int? limit,
  });

  Future<List<ProductModel>> getProductsByIds(List<String> ids);

  Future<ReviewsPageModel> getProductReviews({
    required String productId,
    required int page,
    required int pageSize,
  });

  Future<List<String>> getTrendingSearches();

  /// Sizes, colors and the price range across the catalog.
  Future<ProductFacetsModel> getFacets();
}
