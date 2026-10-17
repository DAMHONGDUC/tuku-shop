import 'package:tuku_shop/src/features/auth/auth_di.dart';
import 'package:tuku_shop/src/features/banner/banner_di.dart';
import 'package:tuku_shop/src/features/category/category_di.dart';
import 'package:tuku_shop/src/features/notification/notification_di.dart';
import 'package:tuku_shop/src/features/order/order_di.dart';
import 'package:tuku_shop/src/features/product/product_di.dart';
import 'package:tuku_shop/src/features/profile/profile_di.dart';
import 'package:tuku_shop/src/features/splash/config/splash_di.dart';
import 'package:tuku_shop/src/features/tutorial/config/tutorial_di.dart';
import 'package:tuku_shop/src/features/wishlist/wishlist_di.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injector {
  static config() {
    // Each feature registers its own data source -> repository -> usecase ->
    // controller chain. There's no cross-feature ordering dependency here:
    // "home" and "bottom_tab" only compose other features' presentation
    // widgets, they don't own any DI of their own.
    AuthDi.config();
    BannerDi.config();
    CategoryDi.config();
    ProductDi.config();
    OrderDi.config();
    NotificationDi.config();
    ProfileDi.config();
    SplashDi.config();
    TutorialDi.config();
    WishlistDi.config();
  }
}
