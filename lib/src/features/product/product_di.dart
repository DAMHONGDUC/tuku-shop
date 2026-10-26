import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source_impl.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/search_history_local_data_source.dart';
import 'package:tuku_shop/src/features/product/data/repositories/product_repository_impl.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorites_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/add_to_cart/add_to_cart_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/product_detail_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/related_product_section/related_products_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/reviews_section/product_reviews_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/shop_section/product_seller_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_selection_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/search_screen/filters/search_filters_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/shop_detail/categories/shop_categories_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/shop_detail/header/shop_header_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/search_screen/search_suggestions_controller.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

class ProductDi {
  static config() {
    getIt.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<SearchHistoryLocalDataSource>(
      () => SearchHistoryLocalDataSourceImpl(),
    );

    getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        dataSource: getIt<ProductRemoteDataSource>(),
        searchHistory: getIt<SearchHistoryLocalDataSource>(),
      ),
    );

    getIt.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(getIt<ProductRepository>()),
    );
    getIt.registerLazySingleton<GetProductDetailUsecase>(
      () => GetProductDetailUsecase(getIt<ProductRepository>()),
    );
    getIt.registerLazySingleton<GetRelatedProductUsecase>(
      () => GetRelatedProductUsecase(getIt<ProductRepository>()),
    );
    getIt.registerLazySingleton<GetProductsByIdsUsecase>(
      () => GetProductsByIdsUsecase(getIt<ProductRepository>()),
    );
    getIt.registerLazySingleton<GetProductReviewsUsecase>(
      () => GetProductReviewsUsecase(getIt<ProductRepository>()),
    );
    getIt.registerLazySingleton<GetProductFacetsUsecase>(
      () => GetProductFacetsUsecase(getIt<ProductRepository>()),
    );
    getIt.registerLazySingleton<GetSearchSuggestionsUsecase>(
      () => GetSearchSuggestionsUsecase(getIt<ProductRepository>()),
    );
    getIt.registerLazySingleton<SaveRecentSearchUsecase>(
      () => SaveRecentSearchUsecase(getIt<ProductRepository>()),
    );
    getIt.registerLazySingleton<ClearRecentSearchesUsecase>(
      () => ClearRecentSearchesUsecase(getIt<ProductRepository>()),
    );

    getIt.registerFactory<ProductListController>(
      () => ProductListController(getIt<GetProductsUsecase>()),
    );
    getIt.registerFactory<ProductDetailController>(
      () => ProductDetailController(getIt<GetProductDetailUsecase>()),
    );
    getIt.registerFactory<VariantSelectionController>(
      () => VariantSelectionController(),
    );
    getIt.registerFactory<AddToCartController>(
      () => AddToCartController(getIt<AddToCartUsecase>()),
    );
    getIt.registerFactory<ProductReviewsController>(
      () => ProductReviewsController(getIt<GetProductReviewsUsecase>()),
    );
    getIt.registerFactory<ProductSellerController>(
      () => ProductSellerController(getIt<GetSellerUsecase>()),
    );
    getIt.registerFactory<ShopHeaderController>(
      () => ShopHeaderController(
        getIt<GetSellerUsecase>(),
        getIt<GetProductsUsecase>(),
        getIt<ToggleFollowSellerUsecase>(),
      ),
    );
    getIt.registerFactory<ShopCategoriesController>(
      () => ShopCategoriesController(
        getIt<GetProductsUsecase>(),
        getIt<GetCategoriesUsecase>(),
      ),
    );
    getIt.registerFactory<RelatedProductsController>(
      () => RelatedProductsController(getIt<GetRelatedProductUsecase>()),
    );
    getIt.registerFactory<SearchFiltersController>(
      () => SearchFiltersController(
        getIt<GetProductFacetsUsecase>(),
        getIt<GetCategoriesUsecase>(),
      ),
    );
    getIt.registerFactory<SearchSuggestionsController>(
      () => SearchSuggestionsController(
        getIt<GetSearchSuggestionsUsecase>(),
        getIt<SaveRecentSearchUsecase>(),
        getIt<ClearRecentSearchesUsecase>(),
      ),
    );
    // App-wide: one instance, provided above the router.
    getIt.registerLazySingleton<FavoritesController>(
      () => FavoritesController(
        getIt<GetWishlistIdsUsecase>(),
        getIt<WatchWishlistIdsUsecase>(),
        getIt<ToggleWishlistUsecase>(),
      ),
    );
  }
}
