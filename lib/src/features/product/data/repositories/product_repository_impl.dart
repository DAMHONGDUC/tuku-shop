import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/search_history_local_data_source.dart';
import 'package:tuku_shop/src/features/product/data/mapper/product_facets_model_to_product_facets_mapper.dart';
import 'package:tuku_shop/src/features/product/data/mapper/product_model_to_product_entity_mapper.dart';
import 'package:tuku_shop/src/features/product/data/mapper/products_data_model_to_products_data_entity_mapper.dart';
import 'package:tuku_shop/src/features/product/data/mapper/review_comment_model_to_review_comment_entity_mapper.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({
    required this.dataSource,
    required this.searchHistory,
  });

  final ProductRemoteDataSource dataSource;
  final SearchHistoryLocalDataSource searchHistory;

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Right(await run());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductsData>> getProducts(ProductQuery query) =>
      _guard(() async {
        final result = await dataSource.getProducts(query);
        return ProductsDataModelToProductsDataEntityMapper.toEntity(result);
      });

  @override
  Future<Either<Failure, ProductFacets>> getFacets() => _guard(() async {
    final result = await dataSource.getFacets();
    return ProductFacetsModelToProductFacetsMapper.toEntity(result);
  });

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail({
    required String productId,
  }) => _guard(() async {
    final result = await dataSource.getProductDetail(productId: productId);
    return ProductModelToProductEntityMapper.toEntity(result);
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getRelatedProducts({
    required String productId,
    int? limit,
  }) => _guard(() async {
    final result = await dataSource.getRelatedProducts(
      productId: productId,
      limit: limit,
    );
    return result.map(ProductModelToProductEntityMapper.toEntity).toList();
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByIds(
    List<String> ids,
  ) => _guard(() async {
    final result = await dataSource.getProductsByIds(ids);
    return result.map(ProductModelToProductEntityMapper.toEntity).toList();
  });

  @override
  Future<Either<Failure, ReviewsPage>> getProductReviews({
    required String productId,
    required int page,
    required int pageSize,
    String? colorName,
    String? size,
  }) => _guard(() async {
    final result = await dataSource.getProductReviews(
      productId: productId,
      page: page,
      pageSize: pageSize,
      colorName: colorName,
      size: size,
    );
    return ReviewsPage(
      items:
          result.items
              ?.map(ReviewCommentModelToReviewCommentEntityMapper.toEntity)
              .toList() ??
          [],
      currentPage: result.currentPage ?? page,
      totalPage: result.totalPage ?? 0,
      totalRecord: result.totalRecord ?? 0,
    );
  });

  @override
  Future<Either<Failure, SearchSuggestions>> getSearchSuggestions() =>
      _guard(() async {
        final results = await Future.wait([
          Future.sync(searchHistory.getRecent),
          Future.sync(dataSource.getTrendingSearches),
        ]);
        return SearchSuggestions(recent: results[0], trending: results[1]);
      });

  @override
  Future<Either<Failure, Unit>> saveRecentSearch(String keyword) =>
      _guard(() async {
        await searchHistory.add(keyword);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> clearRecentSearches() => _guard(() async {
    await searchHistory.clear();
    return unit;
  });
}
