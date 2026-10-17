import 'package:tuku_shop/src/di/injector.dart';

import 'presentation/edit_profile/edit_profile_controller.dart';
import 'presentation/profile/profile_controller.dart';

/// Profile owns no data of its own: it reads the session, orders and
/// wishlist through their usecases, so it registers only its controllers.
class ProfileDi {
  static void config() {
    getIt.registerFactory<ProfileController>(
      () => ProfileController(getOrders: getIt()),
    );
    getIt.registerFactory<EditProfileController>(
      () => EditProfileController(updateProfile: getIt()),
    );
  }
}
