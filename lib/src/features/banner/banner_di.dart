import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/banner/data/data_sources/banner_remote_data_source.dart';
import 'package:tuku_shop/src/features/banner/data/repositories/banner_repository_impl.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';
import 'package:tuku_shop/src/features/banner/presentation/banner_carousel/banner_carousel_controller.dart';

class BannerDi {
  static void config() {
    getIt.registerLazySingleton<BannerRemoteDataSource>(
      () => const BannerRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<BannerRepository>(
      () => BannerRepositoryImpl(dataSource: getIt()),
    );
    getIt.registerLazySingleton<GetBannersUsecase>(
      () => GetBannersUsecase(getIt()),
    );
    getIt.registerFactory<BannerCarouselController>(
      () => BannerCarouselController(getIt()),
    );
  }
}
