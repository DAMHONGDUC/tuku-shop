import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/settings/data/settings_repository_impl.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';
import 'package:tuku_shop/src/features/settings/presentation/locale_controller.dart';

class SettingsDi {
  static config() {
    getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(),
    );
    getIt.registerLazySingleton<GetLanguageUsecase>(
      () => GetLanguageUsecase(getIt<SettingsRepository>()),
    );
    getIt.registerLazySingleton<SetLanguageUsecase>(
      () => SetLanguageUsecase(getIt<SettingsRepository>()),
    );
    // App-wide: one instance, provided above the router.
    getIt.registerLazySingleton<LocaleController>(
      () => LocaleController(
        getIt<GetLanguageUsecase>(),
        getIt<SetLanguageUsecase>(),
      ),
    );
  }
}
