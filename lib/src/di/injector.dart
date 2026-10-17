import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/app/app_di.dart';
import 'package:tuku_shop/src/features/auth/auth_di.dart';
import 'package:tuku_shop/src/features/banner/banner_di.dart';
import 'package:tuku_shop/src/features/cart/cart_di.dart';
import 'package:tuku_shop/src/features/category/category_di.dart';
import 'package:tuku_shop/src/features/checkout/checkout_di.dart';
import 'package:tuku_shop/src/features/notification/notification_di.dart';
import 'package:tuku_shop/src/features/order/order_di.dart';
import 'package:tuku_shop/src/features/product/product_di.dart';
import 'package:tuku_shop/src/features/profile/profile_di.dart';
import 'package:tuku_shop/src/features/settings/settings_di.dart';
import 'package:tuku_shop/src/features/splash/config/splash_di.dart';
import 'package:tuku_shop/src/features/wishlist/wishlist_di.dart';

final GetIt getIt = GetIt.instance;

class Injector {
  /// Registers every feature's data source → repository → usecase →
  /// controller chain, then the app-wide controllers on top.
  static Future<void> config() async {
    getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance(),
    );

    AuthDi.config();
    SettingsDi.config();
    BannerDi.config();
    CategoryDi.config();
    ProductDi.config();
    WishlistDi.config();
    CartDi.config();
    CheckoutDi.config();
    OrderDi.config();
    NotificationDi.config();
    ProfileDi.config();
    SplashDi.config();
    AppDi.config();
  }
}
