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

  @override
  String get common_undo => 'Undo';

  @override
  String cart_title_count(int count) {
    return 'Cart ($count)';
  }

  @override
  String get cart_update_failed => 'Couldn\'t update your cart. Try again.';

  @override
  String get cart_free_shipping_unlocked =>
      'You\'ve unlocked free standard shipping 🎉';

  @override
  String cart_free_shipping_nudge(String amount) {
    return 'Add $amount more for free shipping';
  }

  @override
  String get cart_subtotal => 'Subtotal';

  @override
  String get cart_savings => 'You save';

  @override
  String get cart_shipping => 'Shipping';

  @override
  String get cart_shipping_at_checkout => 'At checkout';

  @override
  String cart_removed(String name) {
    return 'Removed $name';
  }

  @override
  String get cart_remove => 'Remove';

  @override
  String get cart_total => 'Total';

  @override
  String get cart_checkout => 'Checkout';

  @override
  String get pdp_added_to_cart => 'Added to cart';

  @override
  String get pdp_view_cart => 'View cart';

  @override
  String get pdp_add_failed => 'Couldn\'t add to cart. Try again.';

  @override
  String sheet_in_stock(int count) {
    return '$count in stock';
  }

  @override
  String get sheet_quantity => 'Quantity';

  @override
  String sheet_add_to_cart(String total) {
    return 'Add to cart · $total';
  }

  @override
  String sheet_buy_now(String total) {
    return 'Buy now · $total';
  }

  @override
  String get checkout_title => 'Checkout';

  @override
  String get checkout_items_title => 'Items';

  @override
  String checkout_items(int count) {
    return 'Items ($count)';
  }

  @override
  String get checkout_ship_to => 'Ship to';

  @override
  String get checkout_change => 'Change';

  @override
  String get checkout_no_address => 'Add an address to continue';

  @override
  String get checkout_shipping => 'Shipping';

  @override
  String checkout_shipping_days(int min, int max) {
    return '$min–$max days';
  }

  @override
  String get checkout_free => 'Free';

  @override
  String get checkout_payment => 'Payment';

  @override
  String get checkout_voucher => 'Voucher';

  @override
  String get checkout_voucher_hint => 'Enter a code';

  @override
  String get checkout_voucher_invalid => 'This code isn\'t valid';

  @override
  String get checkout_voucher_try => 'Try TUKU10 for 10% off or FREESHIP';

  @override
  String checkout_voucher_percent(String code, int percent) {
    return '$code · $percent% off';
  }

  @override
  String checkout_voucher_free_shipping(String code) {
    return '$code · free standard shipping';
  }

  @override
  String get checkout_apply => 'Apply';

  @override
  String get checkout_summary => 'Summary';

  @override
  String get checkout_discount => 'Discount';

  @override
  String checkout_place_order(String total) {
    return 'Place order · $total';
  }

  @override
  String get checkout_place_failed => 'Couldn\'t place the order. Try again.';

  @override
  String get success_title => 'Order placed!';

  @override
  String get success_message =>
      'Thanks for shopping with us. We\'ll let you know when it ships.';

  @override
  String get success_order => 'Order';

  @override
  String get success_arrives => 'Arrives by';

  @override
  String get success_track => 'Track order';

  @override
  String get success_continue => 'Continue shopping';

  @override
  String get address_book_title => 'Addresses';

  @override
  String get address_pick_title => 'Choose an address';

  @override
  String get address_add => 'Add address';

  @override
  String get address_edit => 'Edit address';

  @override
  String get address_default => 'Default';

  @override
  String get address_set_default => 'Set as default';

  @override
  String get address_delete => 'Delete';

  @override
  String get address_empty_title => 'No addresses yet';

  @override
  String get address_empty_message =>
      'Add where you\'d like your orders delivered.';

  @override
  String get address_full_name => 'Full name';

  @override
  String get address_phone => 'Phone';

  @override
  String get address_street => 'Street and number';

  @override
  String get address_city => 'City';

  @override
  String get address_state => 'State';

  @override
  String get address_postal_code => 'Postal code';

  @override
  String get address_make_default => 'Use as my default address';

  @override
  String get address_save => 'Save address';

  @override
  String get address_save_failed => 'Couldn\'t save the address. Try again.';

  @override
  String get address_field_invalid => 'Check this field';

  @override
  String get orders_title => 'My orders';

  @override
  String get orders_empty_title => 'No orders here';

  @override
  String get orders_empty_message => 'Orders in this status will show up here.';

  @override
  String get order_status_to_confirm => 'To confirm';

  @override
  String get order_status_to_ship => 'To ship';

  @override
  String get order_status_on_the_way => 'On the way';

  @override
  String get order_status_delivered => 'Delivered';

  @override
  String get order_status_cancelled => 'Cancelled';

  @override
  String get order_status_returned => 'Returned';

  @override
  String get order_headline_to_confirm => 'We\'ve received your order';

  @override
  String get order_headline_to_ship => 'Your order is being packed';

  @override
  String get order_headline_on_the_way => 'Your order is on the way';

  @override
  String get order_headline_delivered => 'Delivered. Enjoy!';

  @override
  String get order_headline_cancelled => 'This order was cancelled';

  @override
  String get order_headline_returned => 'This order was returned';

  @override
  String order_eta(String date) {
    return 'Estimated delivery $date';
  }

  @override
  String order_more_items(int count) {
    return '+$count more items';
  }

  @override
  String order_items_total(int count) {
    return '$count items · total';
  }

  @override
  String get order_cancel => 'Cancel order';

  @override
  String get order_cancel_title => 'Cancel this order?';

  @override
  String get order_cancel_message =>
      'We haven\'t confirmed it yet, so nothing will be charged.';

  @override
  String get order_cancel_keep => 'Keep order';

  @override
  String get order_cancel_confirm => 'Cancel order';

  @override
  String get order_cancelled_toast => 'Order cancelled';

  @override
  String get order_buy_again => 'Buy again';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get profile_edit => 'Edit profile';

  @override
  String get profile_save => 'Save changes';

  @override
  String get profile_theme => 'Appearance';

  @override
  String get profile_theme_system => 'System';

  @override
  String get profile_theme_light => 'Light';

  @override
  String get profile_theme_dark => 'Dark';

  @override
  String get profile_language => 'Language';

  @override
  String get profile_reset => 'Reset demo data';

  @override
  String get profile_reset_title => 'Reset demo data?';

  @override
  String get profile_reset_message =>
      'Cart, wishlist, orders, addresses and notifications go back to how they were on first launch. You stay signed in.';

  @override
  String get profile_reset_confirm => 'Reset';

  @override
  String get profile_reset_done => 'Demo data restored';

  @override
  String get profile_logout => 'Log out';

  @override
  String get profile_demo_note => 'Demo build with sample data';

  @override
  String get register_title => 'Create your account';

  @override
  String get register_subtitle =>
      'Save your wishlist, track orders and check out faster.';

  @override
  String get register_password_hint => 'At least 6 characters';

  @override
  String get register_password_short => 'Use at least 6 characters';

  @override
  String get register_button => 'Create account';

  @override
  String get register_have_account => 'Already have an account?';

  @override
  String get register_email_taken =>
      'That email already has an account. Sign in instead.';

  @override
  String get notifications_filter_all => 'All';

  @override
  String get notifications_filter_orders => 'Orders';

  @override
  String get notifications_filter_offers => 'Offers';

  @override
  String get notifications_filter_updates => 'Updates';

  @override
  String get notifications_new => 'New';

  @override
  String get notifications_earlier => 'Earlier';

  @override
  String get notifications_empty_title => 'You\'re all caught up';

  @override
  String get notifications_empty_message =>
      'Order updates and offers will show up here.';

  @override
  String notifications_minutes_ago(int count) {
    return '${count}m ago';
  }

  @override
  String notifications_hours_ago(int count) {
    return '${count}h ago';
  }

  @override
  String notifications_days_ago(int count) {
    return '${count}d ago';
  }

  @override
  String get profile_logout_title => 'Log out?';

  @override
  String get profile_logout_message =>
      'Your cart, wishlist and orders stay saved on this device.';
}
