import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/seller/data/data_sources/seller_remote_data_source.dart';
import 'package:tuku_shop/src/features/seller/data/repositories/seller_repository_impl.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

class SellerDi {
  static config() {
    getIt.registerLazySingleton<SellerRemoteDataSource>(
      () => const SellerRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<SellerRepository>(
      () => SellerRepositoryImpl(dataSource: getIt<SellerRemoteDataSource>()),
    );
    getIt.registerLazySingleton<GetSellerUsecase>(
      () => GetSellerUsecase(getIt<SellerRepository>()),
    );
    getIt.registerLazySingleton<GetSellersByIdsUsecase>(
      () => GetSellersByIdsUsecase(getIt<SellerRepository>()),
    );
  }
}
