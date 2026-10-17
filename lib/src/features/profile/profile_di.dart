import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:tuku_shop/src/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:tuku_shop/src/features/profile/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/profile_controller.dart';

class ProfileDi {
  static config() {
    getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(),
    );

    getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(dataSource: getIt<ProfileRemoteDataSource>()),
    );

    getIt.registerLazySingleton<GetProfileSettingsUsecase>(
      () => GetProfileSettingsUsecase(getIt<ProfileRepository>()),
    );

    getIt.registerFactory<ProfileController>(
      () => ProfileController(
        getIt<GetProfileSettingsUsecase>(),
        getIt<LogoutUsecase>(),
      ),
    );
  }
}
