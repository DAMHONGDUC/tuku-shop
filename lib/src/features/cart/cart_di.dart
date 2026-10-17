import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:tuku_shop/src/features/cart/data/mock/cart_mock.dart';
import 'package:tuku_shop/src/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

class CartDi {
  static void config() {
    getIt.registerLazySingleton<CartRemoteDataSource>(
      () => const CartRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(remote: getIt(), initial: CartMock.seed),
    );

    getIt.registerLazySingleton<WatchCartUsecase>(() => WatchCartUsecase(getIt()));
    getIt.registerLazySingleton<AddToCartUsecase>(() => AddToCartUsecase(getIt()));
    getIt.registerLazySingleton<UpdateCartQuantityUsecase>(
      () => UpdateCartQuantityUsecase(getIt()),
    );
    getIt.registerLazySingleton<RemoveCartItemUsecase>(
      () => RemoveCartItemUsecase(getIt()),
    );
    getIt.registerLazySingleton<ApplyPromoUsecase>(() => ApplyPromoUsecase(getIt()));
    getIt.registerLazySingleton<RemovePromoUsecase>(() => RemovePromoUsecase(getIt()));
    getIt.registerLazySingleton<ClearCartUsecase>(() => ClearCartUsecase(getIt()));
  }
}
