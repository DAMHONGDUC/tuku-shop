import 'package:tuku_shop/src/di/injector.dart';

import '../splash_controller.dart';

class SplashDi {
  static void config() {
    getIt.registerFactory<SplashController>(
      () => SplashController(restoreSession: getIt(), getSettings: getIt()),
    );
  }
}
