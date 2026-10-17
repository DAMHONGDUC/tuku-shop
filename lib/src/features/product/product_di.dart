import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_local_data_source.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source_impl.dart';
import 'package:tuku_shop/src/features/product/data/repositories/product_repository_impl.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'presentation/browse/product_browse_controller.dart';
import 'presentation/flash_sale/flash_sale_controller.dart';
import 'presentation/product_detail/product_detail_controller.dart';
import 'presentation/product_rail_section/product_rail_controller.dart';
import 'presentation/recommended/recommended_controller.dart';
import 'presentation/reviews/product_reviews_controller.dart';
import 'presentation/search/search_controller.dart';
import 'presentation/wishlist/wishlist_controller.dart';

class ProductDi {
  static void config() {
    getIt.registerLazySingleton<ProductRemoteDataSource>(
      ProductRemoteDataSourceImpl.new,
    );
    getIt.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSource(getIt()),
    );
    getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remote: getIt(), local: getIt()),
    );

    getIt.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetProductDetailUsecase>(
      () => GetProductDetailUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetProductsByIdsUsecase>(
      () => GetProductsByIdsUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetRelatedProductsUsecase>(
      () => GetRelatedProductsUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetFlashSaleUsecase>(
      () => GetFlashSaleUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetProductReviewsUsecase>(
      () => GetProductReviewsUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetTrendingSearchesUsecase>(
      () => GetTrendingSearchesUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetRecentSearchesUsecase>(
      () => GetRecentSearchesUsecase(getIt()),
    );
    getIt.registerLazySingleton<SaveRecentSearchUsecase>(
      () => SaveRecentSearchUsecase(getIt()),
    );
    getIt.registerLazySingleton<ClearRecentSearchesUsecase>(
      () => ClearRecentSearchesUsecase(getIt()),
    );

    getIt.registerFactory<FlashSaleController>(
      () => FlashSaleController(getIt()),
    );
    getIt.registerFactory<ProductRailController>(
      () => ProductRailController(getIt()),
    );
    getIt.registerFactory<RecommendedController>(
      () => RecommendedController(getIt()),
    );
    getIt.registerFactory<ProductBrowseController>(
      () =>
          ProductBrowseController(getProducts: getIt(), getCategories: getIt()),
    );
    getIt.registerFactory<ProductSearchController>(
      () => ProductSearchController(
        getRecent: getIt(),
        saveRecent: getIt(),
        clearRecent: getIt(),
        getTrending: getIt(),
      ),
    );
    getIt.registerFactory<ProductDetailController>(
      () => ProductDetailController(
        getProductDetail: getIt(),
        getRelatedProducts: getIt(),
        getReviews: getIt(),
        addToCart: getIt(),
      ),
    );
    getIt.registerFactory<ProductReviewsController>(
      () => ProductReviewsController(getIt()),
    );
    getIt.registerFactory<WishlistScreenController>(
      () => WishlistScreenController(getIt()),
    );
  }
}
