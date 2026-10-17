import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_local_data_source_impl.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:tuku_shop/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import 'presentation/login/login_controller.dart';
import 'presentation/register/register_controller.dart';

class AuthDi {
  static void config() {
    getIt.registerLazySingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl.new);
    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remote: getIt(), local: getIt()),
    );

    getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecase(getIt()));
    getIt.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(getIt()));
    getIt.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(getIt()));
    getIt.registerLazySingleton<RestoreSessionUsecase>(
      () => RestoreSessionUsecase(getIt()),
    );
    getIt.registerLazySingleton<UpdateProfileUsecase>(
      () => UpdateProfileUsecase(getIt()),
    );
    getIt.registerLazySingleton<RequestPasswordResetUsecase>(
      () => RequestPasswordResetUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetDemoAccountUsecase>(
      () => GetDemoAccountUsecase(getIt()),
    );
    getIt.registerLazySingleton<WatchUserUsecase>(() => WatchUserUsecase(getIt()));

    getIt.registerFactory<LoginController>(
      () => LoginController(
        login: getIt(),
        getDemoAccount: getIt(),
        requestPasswordReset: getIt(),
      ),
    );
    getIt.registerFactory<RegisterController>(
      () => RegisterController(register: getIt()),
    );
  }
}
