import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/wishlist/data/data_sources/wishlist_local_data_source.dart';
import 'package:tuku_shop/src/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

class WishlistDi {
  static void config() {
    getIt.registerLazySingleton<WishlistLocalDataSource>(
      () => WishlistLocalDataSource(getIt()),
    );
    getIt.registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<WatchWishlistUsecase>(
      () => WatchWishlistUsecase(getIt()),
    );
    getIt.registerLazySingleton<ToggleWishlistUsecase>(
      () => ToggleWishlistUsecase(getIt()),
    );
  }
}
