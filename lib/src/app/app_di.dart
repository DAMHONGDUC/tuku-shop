import 'package:tuku_shop/src/di/injector.dart';

import 'state/cart_controller.dart';
import 'state/session_controller.dart';
import 'state/settings_controller.dart';
import 'state/unread_notifications_controller.dart';
import 'state/wishlist_controller.dart';

/// The app-wide controllers. Singletons, unlike screen controllers: there is
/// one bag and one session, and every screen reads the same instance.
class AppDi {
  static void config() {
    getIt.registerLazySingleton<SessionController>(
      () => SessionController(
        watchUser: getIt(),
        restoreSession: getIt(),
        logout: getIt(),
      ),
    );
    getIt.registerLazySingleton<SettingsController>(
      () => SettingsController(getSettings: getIt(), saveSettings: getIt()),
    );
    getIt.registerLazySingleton<CartController>(
      () => CartController(
        watchCart: getIt(),
        addToCart: getIt(),
        updateQuantity: getIt(),
        removeItem: getIt(),
        applyPromo: getIt(),
        removePromo: getIt(),
        clearCart: getIt(),
      ),
    );
    getIt.registerLazySingleton<WishlistController>(
      () => WishlistController(watchWishlist: getIt(), toggleWishlist: getIt()),
    );
    getIt.registerLazySingleton<UnreadNotificationsController>(
      () => UnreadNotificationsController(watchUnread: getIt()),
    );
  }
}
