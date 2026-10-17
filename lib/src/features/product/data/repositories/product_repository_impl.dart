import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_local_data_source.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:tuku_shop/src/features/product/data/mapper/product_model_to_product_entity_mapper.dart';
import 'package:tuku_shop/src/features/product/data/mapper/review_model_to_review_entity_mapper.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({required this.remote, required this.local});

  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;

  static const String _tag = 'ProductRepository';

  Future<Either<Failure, T>> _guard<T>(
    String action,
    Future<T> Function() run,
  ) async {
    try {
      return Right<Failure, T>(await run());
    } on ServerException catch (e, stackTrace) {
      SdLogger.error(_tag, action, error: e, stackTrace: stackTrace);
      return Left<Failure, T>(const ServerFailure());
    } catch (e, stackTrace) {
      SdLogger.error(_tag, action, error: e, stackTrace: stackTrace);
      return Left<Failure, T>(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductPage>> getProducts(ProductQuery query) =>
      _guard(
        'Load products failed',
        () async => ProductModelToProductEntityMapper.pageToEntity(
          await remote.getProducts(query),
        ),
      );

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail(String id) => _guard(
    'Load product failed',
    () async => ProductModelToProductEntityMapper.toEntity(
      await remote.getProductDetail(id),
    ),
  );

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByIds(
    List<String> ids,
  ) => _guard(
    'Load products by id failed',
    () async => (await remote.getProductsByIds(ids))
        .map(ProductModelToProductEntityMapper.toEntity)
        .toList(),
  );

  @override
  Future<Either<Failure, List<ProductEntity>>> getRelatedProducts(String id) =>
      _guard(
        'Load related failed',
        () async => (await remote.getRelatedProducts(id))
            .map(ProductModelToProductEntityMapper.toEntity)
            .toList(),
      );

  @override
  Future<Either<Failure, FlashSaleEntity>> getFlashSale() =>
      _guard('Load flash sale failed', () async {
        final ({DateTime endsAt, List<ProductModel> products}) sale =
            await remote.getFlashSale();

        return FlashSaleEntity(
          endsAt: sale.endsAt,
          products: sale.products
              .map(ProductModelToProductEntityMapper.toEntity)
              .toList(),
        );
      });

  @override
  Future<Either<Failure, ReviewsPage>> getReviews({
    required String productId,
    required int page,
  }) => _guard(
    'Load reviews failed',
    () async => ReviewModelToReviewEntityMapper.pageToEntity(
      await remote.getReviews(productId: productId, page: page),
    ),
  );

  @override
  Future<Either<Failure, List<String>>> getTrendingSearches() =>
      _guard('Load trending failed', remote.getTrendingSearches);

  @override
  Future<Either<Failure, List<String>>> getRecentSearches() =>
      _guard('Read recent failed', () async => local.readRecent());

  @override
  Future<Either<Failure, List<String>>> saveRecentSearch(String keyword) =>
      _guard('Save recent failed', () => local.addRecent(keyword));

  @override
  Future<Either<Failure, Unit>> clearRecentSearches() =>
      _guard('Clear recent failed', () async {
        await local.clearRecent();
        return unit;
      });
}
