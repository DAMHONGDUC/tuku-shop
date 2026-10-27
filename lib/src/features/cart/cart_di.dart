import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:tuku_shop/src/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/presentation/cart/cart_controller.dart';

class CartDi {
  static config() {
    getIt.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(dataSource: getIt<CartLocalDataSource>()),
    );
    getIt.registerLazySingleton<GetCartUsecase>(
      () => GetCartUsecase(getIt<CartRepository>()),
    );
    getIt.registerLazySingleton<WatchCartUsecase>(
      () => WatchCartUsecase(getIt<CartRepository>()),
    );
    getIt.registerLazySingleton<AddToCartUsecase>(
      () => AddToCartUsecase(getIt<CartRepository>()),
    );
    getIt.registerLazySingleton<UpdateCartQuantityUsecase>(
      () => UpdateCartQuantityUsecase(getIt<CartRepository>()),
    );
    getIt.registerLazySingleton<RemoveCartLineUsecase>(
      () => RemoveCartLineUsecase(getIt<CartRepository>()),
    );
    getIt.registerLazySingleton<RemoveCartLinesUsecase>(
      () => RemoveCartLinesUsecase(getIt<CartRepository>()),
    );
    getIt.registerLazySingleton<ResetCartUsecase>(
      () => ResetCartUsecase(getIt<CartRepository>()),
    );
    // App-wide: one instance, provided above the router.
    getIt.registerLazySingleton<CartController>(
      () => CartController(
        getIt<GetCartUsecase>(),
        getIt<WatchCartUsecase>(),
        getIt<UpdateCartQuantityUsecase>(),
        getIt<RemoveCartLineUsecase>(),
        getIt<AddToCartUsecase>(),
      ),
    );
  }
}
