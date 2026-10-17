// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Tuku Shop';

  @override
  String get splash_description => 'Any shopping just from home';

  @override
  String get login_title => 'Welcome back';

  @override
  String get login_subtitle => 'Sign in to continue shopping';

  @override
  String get login_email_label => 'Email';

  @override
  String get login_email_hint => 'you@example.com';

  @override
  String get login_password_label => 'Password';

  @override
  String get login_password_hint => 'Enter your password';

  @override
  String get login_button => 'Sign in';

  @override
  String get login_signing_in => 'Signing in...';

  @override
  String get login_no_account => 'Don\'t have an account?';

  @override
  String get login_register => 'Register';

  @override
  String get login_demo_title => 'Demo account';

  @override
  String get login_demo_fill => 'Use demo account';

  @override
  String get login_error_email_empty => 'Please enter your email';

  @override
  String get login_error_email_invalid => 'Please enter a valid email';

  @override
  String get login_error_password_empty => 'Please enter your password';

  @override
  String get login_error_invalid_credentials => 'Incorrect email or password';

  @override
  String get login_error_unknown => 'Something went wrong. Please try again';

  @override
  String get logout_failed => 'Could not log out. Please try again';

  @override
  String get common_retry => 'Retry';

  @override
  String get common_load_failed =>
      'Couldn\'t load this. Check your connection and try again.';

  @override
  String get common_see_all => 'See all';

  @override
  String common_items_count(int count) {
    return '$count items';
  }

  @override
  String get common_start_shopping => 'Start shopping';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_categories => 'Categories';

  @override
  String get nav_wishlist => 'Wishlist';

  @override
  String get nav_cart => 'Cart';

  @override
  String get nav_profile => 'Profile';

  @override
  String get home_search_hint => 'Search dresses, jeans…';

  @override
  String get home_categories => 'Categories';

  @override
  String get home_flash_sale => 'Flash sale';

  @override
  String get home_new_arrivals => 'New arrivals';

  @override
  String get home_best_sellers => 'Best sellers';

  @override
  String get home_just_for_you => 'Just for you';

  @override
  String get categories_title => 'Categories';

  @override
  String products_count(int count) {
    return '$count products';
  }

  @override
  String get sort_recommended => 'Recommended';

  @override
  String get sort_newest => 'Newest';

  @override
  String get sort_price_low => 'Price: low to high';

  @override
  String get sort_price_high => 'Price: high to low';

  @override
  String get sort_rating => 'Top rated';

  @override
  String get filter_on_sale => 'On sale';

  @override
  String get products_empty_title => 'Nothing here yet';

  @override
  String get products_empty_message => 'Try another filter or category.';

  @override
  String get search_hint => 'Search products';

  @override
  String get search_recent => 'Recent';

  @override
  String get search_clear => 'Clear';

  @override
  String get search_trending => 'Trending';

  @override
  String get search_recommended => 'Recommended for you';

  @override
  String get search_no_results_title => 'No matches';

  @override
  String get search_no_results_message =>
      'Check the spelling or try a broader word, like \"dress\" or \"jeans\".';

  @override
  String get badge_new => 'New';

  @override
  String badge_discount(int percent) {
    return '-$percent%';
  }

  @override
  String get pdp_color => 'Color';

  @override
  String get pdp_size => 'Size';

  @override
  String pdp_only_left(int count) {
    return 'Only $count left';
  }

  @override
  String get pdp_sold_out => 'Sold out';

  @override
  String get pdp_select_size => 'Pick a size first';

  @override
  String get pdp_free_shipping => 'Free shipping';

  @override
  String get pdp_free_shipping_sub => 'over \$100';

  @override
  String get pdp_delivery => '2–4 days';

  @override
  String get pdp_delivery_sub => 'delivery';

  @override
  String get pdp_returns => '30 days';

  @override
  String get pdp_returns_sub => 'free returns';

  @override
  String get pdp_details => 'Details';

  @override
  String get pdp_material => 'Material';

  @override
  String get pdp_fit => 'Fit';

  @override
  String get pdp_reviews => 'Reviews';

  @override
  String pdp_reviews_count(int count) {
    return '$count reviews';
  }

  @override
  String get pdp_show_more_reviews => 'Show more reviews';

  @override
  String get pdp_related => 'You may also like';

  @override
  String get pdp_add_to_cart => 'Add to cart';

  @override
  String get pdp_buy_now => 'Buy now';

  @override
  String pdp_sold(int count) {
    return '$count sold';
  }

  @override
  String get wishlist_title => 'Wishlist';

  @override
  String wishlist_title_count(int count) {
    return 'Wishlist ($count)';
  }

  @override
  String get wishlist_empty_title => 'Save what you love';

  @override
  String get wishlist_empty_message =>
      'Tap the heart on any item to keep it here for later.';

  @override
  String get cart_title => 'Cart';

  @override
  String get cart_empty_title => 'Your cart is empty';

  @override
  String get cart_empty_message => 'Find something you like and add it here.';

  @override
  String get notifications_title => 'Notifications';
}
