/// One route of the app: the name `go_router` knows it by and its path.
class AppRoute {
  const AppRoute(this.name, this.path);

  final String name;
  final String path;
}

/// Every route, defined once. Features navigate by these constants rather
/// than importing each other's screens.
abstract final class AppRoutes {
  static const AppRoute splash = AppRoute('splash', '/');
  static const AppRoute onboarding = AppRoute('onboarding', '/onboarding');
  static const AppRoute login = AppRoute('login', '/login');
  static const AppRoute register = AppRoute('register', '/register');

  // Tabs.
  static const AppRoute home = AppRoute('home', '/home');
  static const AppRoute shop = AppRoute('shop', '/shop');
  static const AppRoute wishlist = AppRoute('wishlist', '/wishlist');
  static const AppRoute cart = AppRoute('cart', '/cart');
  static const AppRoute profile = AppRoute('profile', '/profile');

  // Full-screen routes above the tabs.
  static const AppRoute search = AppRoute('search', '/search');
  static const AppRoute productList = AppRoute('product-list', '/products');
  static const AppRoute productDetail = AppRoute(
    'product-detail',
    '/product/:id',
  );
  static const AppRoute productReviews = AppRoute(
    'product-reviews',
    '/product/:id/reviews',
  );
  static const AppRoute checkout = AppRoute('checkout', '/checkout');
  static const AppRoute orderSuccess = AppRoute(
    'order-success',
    '/order-success/:id',
  );
  static const AppRoute orders = AppRoute('orders', '/orders');
  static const AppRoute orderDetail = AppRoute('order-detail', '/orders/:id');
  static const AppRoute notifications = AppRoute(
    'notifications',
    '/notifications',
  );
  static const AppRoute editProfile = AppRoute('edit-profile', '/edit-profile');
  static const AppRoute addresses = AppRoute('addresses', '/addresses');
  static const AppRoute addressForm = AppRoute('address-form', '/address-form');
  static const AppRoute paymentMethods = AppRoute(
    'payment-methods',
    '/payment-methods',
  );
  static const AppRoute settings = AppRoute('settings', '/settings');
  static const AppRoute helpCenter = AppRoute('help-center', '/help-center');

  /// The path parameter every `:id` route reads.
  static const String idParam = 'id';
}
