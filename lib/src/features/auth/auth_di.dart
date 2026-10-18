import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/auth/presentation/login/login_controller.dart';

class AuthDi {
  static config() {
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
    );

    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        localDataSource: getIt<AuthLocalDataSource>(),
      ),
    );

    getIt.registerLazySingleton<GetCurrentUserUsecase>(
      () => GetCurrentUserUsecase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<UpdateProfileUsecase>(
      () => UpdateProfileUsecase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<LogoutUsecase>(
      () => LogoutUsecase(getIt<AuthRepository>()),
    );

    getIt.registerFactory<LoginController>(
      () => LoginController(getIt<LoginUsecase>()),
    );
  }
}
