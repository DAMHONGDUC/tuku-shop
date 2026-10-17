import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/flash_sale_entity.dart';
import '../entities/product_entity.dart';
import '../entities/product_page.dart';
import '../entities/product_query.dart';
import '../entities/reviews_page.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductPage>> getProducts(ProductQuery query);

  Future<Either<Failure, ProductEntity>> getProductDetail(String id);

  Future<Either<Failure, List<ProductEntity>>> getProductsByIds(
    List<String> ids,
  );

  Future<Either<Failure, List<ProductEntity>>> getRelatedProducts(String id);

  Future<Either<Failure, FlashSaleEntity>> getFlashSale();

  Future<Either<Failure, ReviewsPage>> getReviews({
    required String productId,
    required int page,
  });

  Future<Either<Failure, List<String>>> getTrendingSearches();

  Future<Either<Failure, List<String>>> getRecentSearches();

  Future<Either<Failure, List<String>>> saveRecentSearch(String keyword);

  Future<Either<Failure, Unit>> clearRecentSearches();
}
