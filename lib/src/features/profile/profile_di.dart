import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/presentation/edit_profile/edit_profile_controller.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/favorites_preview/favorites_preview_controller.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/profile_controller.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

/// Profile has no data of its own: it composes auth, orders, favorites and
/// the reset steps of every feature.
class ProfileDi {
  static config() {
    getIt.registerFactory<ProfileController>(
      () => ProfileController(
        getCurrentUser: getIt<GetCurrentUserUsecase>(),
        getOrderCounts: getIt<GetOrderCountsUsecase>(),
        watchOrderChanges: getIt<WatchOrderChangesUsecase>(),
        logout: getIt<LogoutUsecase>(),
        resetSteps: demoResetSteps(
          cart: getIt<ResetCartUsecase>(),
          wishlist: getIt<ResetWishlistUsecase>(),
          orders: getIt<ResetOrdersUsecase>(),
          addresses: getIt<ResetAddressesUsecase>(),
          notifications: getIt<ResetNotificationsUsecase>(),
          searches: getIt<ClearRecentSearchesUsecase>(),
          chat: getIt<ResetChatUsecase>(),
          follows: getIt<ResetFollowedSellersUsecase>(),
        ),
      ),
    );
    getIt.registerFactory<FavoritesPreviewController>(
      () => FavoritesPreviewController(
        getIt<GetWishlistIdsUsecase>(),
        getIt<WatchWishlistIdsUsecase>(),
        getIt<GetProductsByIdsUsecase>(),
      ),
    );
    getIt.registerFactory<EditProfileController>(
      () => EditProfileController(
        getIt<GetCurrentUserUsecase>(),
        getIt<UpdateProfileUsecase>(),
      ),
    );
  }
}
