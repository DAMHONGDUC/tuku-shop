import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:tuku_shop/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

class SettingsDi {
  static void config() {
    getIt.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSource(getIt()),
    );
    getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<GetSettingsUsecase>(
      () => GetSettingsUsecase(getIt()),
    );
    getIt.registerLazySingleton<SaveSettingsUsecase>(
      () => SaveSettingsUsecase(getIt()),
    );
  }
}
