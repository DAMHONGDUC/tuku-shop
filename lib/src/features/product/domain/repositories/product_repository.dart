import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsData>> getProducts(ProductQuery query);

  Future<Either<Failure, ProductEntity>> getProductDetail({
    required String productId,
  });

  Future<Either<Failure, List<ProductEntity>>> getRelatedProducts({
    required String productId,
    int? limit,
  });

  Future<Either<Failure, List<ProductEntity>>> getProductsByIds(
    List<String> ids,
  );

  Future<Either<Failure, ReviewsPage>> getProductReviews({
    required String productId,
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, SearchSuggestions>> getSearchSuggestions();

  Future<Either<Failure, Unit>> saveRecentSearch(String keyword);

  Future<Either<Failure, Unit>> clearRecentSearches();
}
