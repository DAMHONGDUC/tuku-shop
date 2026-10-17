import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/wishlist/data/data_sources/wishlist_local_data_source.dart';
import 'package:tuku_shop/src/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';
import 'package:tuku_shop/src/features/wishlist/presentation/wishlist/wishlist_controller.dart';

class WishlistDi {
  static config() {
    getIt.registerLazySingleton<WishlistLocalDataSource>(
      () => WishlistLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<WishlistRepository>(
      () =>
          WishlistRepositoryImpl(dataSource: getIt<WishlistLocalDataSource>()),
    );
    getIt.registerLazySingleton<GetWishlistIdsUsecase>(
      () => GetWishlistIdsUsecase(getIt<WishlistRepository>()),
    );
    getIt.registerLazySingleton<WatchWishlistIdsUsecase>(
      () => WatchWishlistIdsUsecase(getIt<WishlistRepository>()),
    );
    getIt.registerLazySingleton<ToggleWishlistUsecase>(
      () => ToggleWishlistUsecase(getIt<WishlistRepository>()),
    );
    getIt.registerLazySingleton<ResetWishlistUsecase>(
      () => ResetWishlistUsecase(getIt<WishlistRepository>()),
    );

    getIt.registerFactory<WishlistController>(
      () => WishlistController(
        getIt<GetWishlistIdsUsecase>(),
        getIt<WatchWishlistIdsUsecase>(),
        getIt<ToggleWishlistUsecase>(),
        getIt<GetProductsByIdsUsecase>(),
      ),
    );
  }
}
