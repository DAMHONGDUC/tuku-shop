import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/splash/splash_controller.dart';

class SplashDi {
  static config() {
    getIt.registerFactory<SplashController>(
      () => SplashController(getIt<GetCurrentUserUsecase>()),
    );
  }
}
