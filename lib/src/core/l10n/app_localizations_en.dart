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
  String get error_title => 'Something went wrong';

  @override
  String get error_message =>
      'We couldn\'t load this right now. Check your connection and try again.';

  @override
  String get action_retry => 'Try again';

  @override
  String get tab_home => 'Home';

  @override
  String get tab_shop => 'Shop';

  @override
  String get tab_wishlist => 'Saved';

  @override
  String get tab_bag => 'Bag';

  @override
  String get tab_profile => 'Profile';

  @override
  String get splash_tagline => 'Wear what moves you';

  @override
  String get action_skip => 'Skip';

  @override
  String get action_next => 'Next';

  @override
  String get onboarding_title_1 => 'Dress for\nthe way you move';

  @override
  String get onboarding_body_1 =>
      'Performance pieces and everyday layers, picked for comfort that lasts from the studio to the street.';

  @override
  String get onboarding_title_2 => 'Discover\nyour style';

  @override
  String get onboarding_body_2 =>
      'Browse new arrivals, curated edits and members-only drops — all in one place.';

  @override
  String get onboarding_title_3 => 'Fast delivery,\neasy returns';

  @override
  String get onboarding_body_3 =>
      'Free shipping over \$75, live order tracking and 30-day returns. Shopping, simplified.';

  @override
  String get onboarding_start => 'Get started';

  @override
  String get action_close => 'Close';

  @override
  String get login_title => 'Welcome back';

  @override
  String get login_subtitle => 'Sign in to pick up where you left off.';

  @override
  String get login_demo_title => 'Demo account';

  @override
  String get login_demo_fill => 'Fill';

  @override
  String get field_email => 'Email';

  @override
  String get field_email_hint => 'you@example.com';

  @override
  String get field_password => 'Password';

  @override
  String get password_show => 'Show password';

  @override
  String get password_hide => 'Hide password';

  @override
  String get login_remember => 'Remember me';

  @override
  String get login_forgot => 'Forgot password?';

  @override
  String get login_submit => 'Sign in';

  @override
  String get login_or => 'or continue with';

  @override
  String get login_social_demo =>
      'Social sign-in is off in this demo — use the demo account.';

  @override
  String get login_no_account => 'New to Tuku?';

  @override
  String get login_create_account => 'Create an account';

  @override
  String get forgot_title => 'Reset password';

  @override
  String get forgot_body =>
      'Enter the email you signed up with and we\'ll send you a link to choose a new password.';

  @override
  String get forgot_submit => 'Send reset link';

  @override
  String forgot_sent(String email) {
    return 'Reset link sent to $email';
  }

  @override
  String get validation_required => 'This field is required';

  @override
  String get validation_email => 'Enter a valid email address';

  @override
  String get validation_password_short => 'Use at least 8 characters';

  @override
  String get validation_password_mismatch => 'Passwords don\'t match';

  @override
  String get auth_error_credentials =>
      'That email and password don\'t match. Try the demo account.';

  @override
  String get auth_error_email_taken =>
      'An account with this email already exists.';

  @override
  String get register_title => 'Create account';

  @override
  String get register_subtitle =>
      'Join Tuku for members-only prices, faster checkout and order tracking.';

  @override
  String get field_full_name => 'Full name';

  @override
  String get field_full_name_hint => 'Alex Morgan';

  @override
  String get field_confirm_password => 'Confirm password';

  @override
  String get register_terms =>
      'I agree to the Terms of Service and Privacy Policy';

  @override
  String get register_accept_terms => 'Please accept the terms to continue';

  @override
  String get register_submit => 'Create account';

  @override
  String get register_have_account => 'Already a member?';

  @override
  String get register_welcome =>
      'Welcome to Tuku! 200 points added to your account.';

  @override
  String get password_weak => 'Weak';

  @override
  String get password_fair => 'Fair';

  @override
  String get password_good => 'Good';

  @override
  String get password_strong => 'Strong';

  @override
  String get action_shop_now => 'Shop now';

  @override
  String get action_see_all => 'See all';

  @override
  String get home_categories => 'Categories';

  @override
  String get badge_new => 'NEW';

  @override
  String get wishlist_add => 'Save to wishlist';

  @override
  String get wishlist_remove => 'Remove from wishlist';

  @override
  String get sort_recommended => 'Recommended';

  @override
  String get sort_newest => 'Newest';

  @override
  String get sort_price_low => 'Price: low to high';

  @override
  String get sort_price_high => 'Price: high to low';

  @override
  String get sort_top_rated => 'Top rated';

  @override
  String get sort_best_selling => 'Best selling';

  @override
  String get gender_all => 'All';

  @override
  String get gender_men => 'Men';

  @override
  String get gender_women => 'Women';

  @override
  String get gender_unisex => 'Unisex';

  @override
  String get home_flash_sale => 'Flash sale';

  @override
  String get home_flash_sale_subtitle =>
      'Deepest markdowns, for a few hours only';

  @override
  String get home_flash_sale_all => 'Shop the whole sale';

  @override
  String home_flash_sale_ends(String time) {
    return 'Sale ends in $time';
  }

  @override
  String get home_recommended => 'Picked for you';

  @override
  String get home_recommended_subtitle => 'Based on what\'s trending this week';

  @override
  String get search_hint => 'Search hoodies, leggings, bags…';

  @override
  String get home_greeting_morning => 'Good morning';

  @override
  String get home_greeting_afternoon => 'Good afternoon';

  @override
  String get home_greeting_evening => 'Good evening';

  @override
  String get home_guest => 'there';

  @override
  String get notifications_title => 'Notifications';

  @override
  String get perk_shipping => 'Free shipping\nover \$75';

  @override
  String get perk_returns => '30-day\nreturns';

  @override
  String get perk_secure => 'Secure\ncheckout';

  @override
  String get home_new_arrivals => 'New arrivals';

  @override
  String get home_new_arrivals_subtitle => 'Fresh drops this week';

  @override
  String get home_best_sellers => 'Best sellers';

  @override
  String get home_lookbook => 'Shop the look';

  @override
  String get home_lookbook_subtitle => 'Edits from our studio';

  @override
  String get home_look_women => 'Studio to street';

  @override
  String get home_look_men => 'Built for the coast';

  @override
  String get home_look_performance => 'Performance edit';

  @override
  String get home_look_performance_caption => 'Our highest-rated pieces';

  @override
  String get browse_empty_title => 'Nothing matches yet';

  @override
  String get browse_empty_message =>
      'Try a different category or loosen your filters.';

  @override
  String browse_end(int count) {
    return 'That\'s all $count pieces';
  }

  @override
  String get browse_all_categories => 'All';

  @override
  String get browse_loading => 'Loading…';

  @override
  String browse_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get sort_title => 'Sort by';

  @override
  String get filter_title => 'Filters';

  @override
  String get filter_reset => 'Reset';

  @override
  String get filter_clear => 'Clear filters';

  @override
  String get filter_apply => 'Show results';

  @override
  String get filter_price => 'Price';

  @override
  String get filter_size => 'Size';

  @override
  String get filter_color => 'Colour';

  @override
  String get filter_on_sale => 'On sale only';

  @override
  String get filter_new_only => 'New arrivals only';

  @override
  String get shop_title => 'Shop';

  @override
  String get search_title => 'Search';

  @override
  String get search_clear => 'Clear';

  @override
  String get search_recent => 'Recent searches';

  @override
  String get search_clear_recent => 'Clear';

  @override
  String get search_trending => 'Trending now';

  @override
  String get action_share => 'Share';

  @override
  String get action_decrease => 'Decrease';

  @override
  String get action_increase => 'Increase';

  @override
  String get detail_link_copied => 'Product link copied';

  @override
  String get detail_related => 'You may also like';

  @override
  String get badge_eco => 'Eco';

  @override
  String get badge_best_seller => 'Best seller';

  @override
  String detail_rating(String rating) {
    return 'Rated $rating out of 5';
  }

  @override
  String detail_reviews(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reviews',
      one: '1 review',
    );
    return '$_temp0';
  }

  @override
  String detail_sold(String sold) {
    return '$sold sold';
  }

  @override
  String detail_save(String amount) {
    return 'Save $amount';
  }

  @override
  String get detail_color => 'Colour';

  @override
  String get detail_size => 'Size';

  @override
  String get detail_size_pick => 'Pick a size';

  @override
  String get detail_size_guide => 'Size guide';

  @override
  String get detail_quantity => 'Quantity';

  @override
  String get size_guide_tops =>
      'Body measurements in inches. Between sizes? Size up for a relaxed fit.';

  @override
  String get size_guide_bottoms => 'Waist measurement in inches.';

  @override
  String get size_guide_note =>
      'Free exchanges within 30 days if the fit isn\'t right.';

  @override
  String get size_chest => 'Chest';

  @override
  String get size_waist => 'Waist';

  @override
  String get size_hips => 'Hips';

  @override
  String get detail_perk_shipping => 'Free delivery over \$75';

  @override
  String get detail_perk_shipping_sub => 'Arrives in 3–5 business days';

  @override
  String get detail_perk_returns => 'Free 30-day returns';

  @override
  String get detail_perk_returns_sub => 'Not the right fit? Send it back on us';

  @override
  String get detail_description => 'Description';

  @override
  String get detail_material => 'Material';

  @override
  String get detail_read_more => 'Read more';

  @override
  String get detail_read_less => 'Show less';

  @override
  String review_variant(String color, String size) {
    return 'Size $size · $color';
  }

  @override
  String review_helpful(int count) {
    return '$count found this helpful';
  }

  @override
  String get detail_reviews_title => 'Reviews';

  @override
  String detail_all_reviews(int count) {
    return 'Read all $count reviews';
  }

  @override
  String get detail_choose_size => 'Choose a size first';

  @override
  String get detail_added => 'Added to your bag';

  @override
  String get detail_view_bag => 'View bag';

  @override
  String get detail_add_to_bag => 'Add to bag';

  @override
  String get reviews_empty => 'No reviews with this rating yet';

  @override
  String get wishlist_title => 'Saved';

  @override
  String wishlist_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pieces saved',
      one: '1 piece saved',
      zero: 'Nothing saved yet',
    );
    return '$_temp0';
  }

  @override
  String get wishlist_empty_title => 'Your wishlist is empty';

  @override
  String get wishlist_empty_message =>
      'Tap the heart on anything you love and it\'ll wait for you here.';

  @override
  String get wishlist_move_to_bag => 'Add to bag';

  @override
  String get action_start_shopping => 'Start shopping';

  @override
  String get cart_title => 'Bag';

  @override
  String cart_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get cart_empty_title => 'Your bag is empty';

  @override
  String get cart_empty_message =>
      'Everything you add will show up here, ready for checkout.';

  @override
  String cart_removed(String name) {
    return 'Removed $name';
  }

  @override
  String get cart_checkout => 'Checkout';

  @override
  String get cart_free_shipping_unlocked => 'You\'ve unlocked free shipping';

  @override
  String cart_free_shipping_more(String amount) {
    return 'Add $amount more for free shipping';
  }

  @override
  String get action_remove => 'Remove';

  @override
  String get action_apply => 'Apply';

  @override
  String get promo_label => 'Promo code';

  @override
  String get promo_hint => 'Try TUKU10';

  @override
  String get promo_applied => 'Promo code applied';

  @override
  String get promo_error_invalid =>
      'That code isn\'t valid. Try TUKU10, WELCOME20 or FREESHIP.';

  @override
  String get promo_error_minimum =>
      'This code needs a subtotal of \$100 or more.';

  @override
  String get promo_free_shipping => 'Free shipping';

  @override
  String promo_percent_off(int percent) {
    return '$percent% off your order';
  }

  @override
  String get summary_subtotal => 'Subtotal';

  @override
  String get summary_discount => 'Discount';

  @override
  String get summary_shipping => 'Shipping';

  @override
  String get summary_free => 'Free';

  @override
  String get summary_total => 'Total';

  @override
  String summary_savings(String amount) {
    return 'You save $amount';
  }

  @override
  String get checkout_title => 'Checkout';

  @override
  String get checkout_address => 'Shipping address';

  @override
  String get checkout_delivery => 'Delivery';

  @override
  String get checkout_payment => 'Payment';

  @override
  String checkout_items(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get checkout_place_order => 'Place order';

  @override
  String get checkout_secure_note =>
      'Payments are encrypted. This demo never charges a real card.';

  @override
  String get checkout_failed =>
      'We couldn\'t place your order. Please try again.';

  @override
  String get action_change => 'Change';

  @override
  String get address_add => 'Add a new address';

  @override
  String get delivery_standard => 'Standard';

  @override
  String get delivery_express => 'Express';

  @override
  String get delivery_next_day => 'Next day';

  @override
  String delivery_eta_range(String from, String to) {
    return 'Arrives $from – $to';
  }

  @override
  String delivery_eta_single(String date) {
    return 'Arrives $date';
  }

  @override
  String get payment_cod => 'Cash on delivery';

  @override
  String get success_title => 'Order placed!';

  @override
  String get success_message =>
      'Thank you for shopping with Tuku. We\'ve emailed your receipt and will let you know when it ships.';

  @override
  String get success_order_number => 'Order number';

  @override
  String get success_eta => 'Estimated delivery';

  @override
  String get success_track => 'Track my order';

  @override
  String get success_continue => 'Continue shopping';

  @override
  String get action_cancel => 'Cancel';

  @override
  String get addresses_title => 'Addresses';

  @override
  String get addresses_empty => 'No saved addresses yet';

  @override
  String get address_default => 'DEFAULT';

  @override
  String get address_make_default => 'Set as default';

  @override
  String get address_delete_title => 'Delete this address?';

  @override
  String get address_new_title => 'New address';

  @override
  String get address_edit_title => 'Edit address';

  @override
  String get address_saved => 'Address saved';

  @override
  String get address_label => 'Save as';

  @override
  String get address_label_home => 'Home';

  @override
  String get address_label_office => 'Office';

  @override
  String get address_label_other => 'Other';

  @override
  String get address_save => 'Save address';

  @override
  String get field_phone => 'Phone';

  @override
  String get field_street => 'Street address';

  @override
  String get field_city => 'City';

  @override
  String get field_postal => 'Postal code';

  @override
  String get field_country => 'Country';

  @override
  String get payment_title => 'Payment methods';

  @override
  String get payment_methods => 'Saved methods';

  @override
  String get payment_add_card => 'Add a card';

  @override
  String get payment_add_demo => 'Adding cards is off in this demo.';

  @override
  String get orders_title => 'My orders';

  @override
  String get orders_filter_all => 'All';

  @override
  String get orders_filter_active => 'In progress';

  @override
  String get orders_filter_delivered => 'Delivered';

  @override
  String get orders_filter_cancelled => 'Cancelled';

  @override
  String get orders_empty_title => 'No orders here';

  @override
  String get orders_empty_message =>
      'When you place an order, you can follow it from here.';

  @override
  String get order_status_placed => 'Placed';

  @override
  String get order_status_processing => 'Processing';

  @override
  String get order_status_shipped => 'Shipped';

  @override
  String get order_status_out => 'Out for delivery';

  @override
  String get order_status_delivered => 'Delivered';

  @override
  String get order_status_cancelled => 'Cancelled';

  @override
  String get order_detail_title => 'Order';

  @override
  String get order_shipping_info => 'Delivery & payment';

  @override
  String get order_tracking => 'Tracking';

  @override
  String order_delivered_on(String date) {
    return 'Delivered $date';
  }

  @override
  String order_arriving(String date) {
    return 'Arriving by $date';
  }

  @override
  String get order_cancelled_note => 'Refunded to your original payment method';

  @override
  String get order_cancel => 'Cancel order';

  @override
  String get order_cancel_title => 'Cancel this order?';

  @override
  String get order_cancel_message =>
      'It hasn\'t shipped yet, so you\'ll get a full refund.';

  @override
  String get order_cancel_confirm => 'Yes, cancel it';

  @override
  String get order_keep => 'Keep my order';

  @override
  String get order_cancelled_toast => 'Order cancelled';

  @override
  String get order_buy_again => 'Buy again';

  @override
  String get order_bought_again => 'Items added to your bag';

  @override
  String get order_write_review => 'Write a review';

  @override
  String get order_review_thanks =>
      'Reviews open in the full app — thanks for trying the demo!';

  @override
  String get order_help => 'Need help with this order?';

  @override
  String get notifications_mark_all => 'Mark all read';

  @override
  String get notifications_empty => 'You\'re all caught up';

  @override
  String get notifications_today => 'Today';

  @override
  String get notifications_earlier => 'Earlier';

  @override
  String time_minutes_ago(int n) {
    return '${n}m ago';
  }

  @override
  String time_hours_ago(int n) {
    return '${n}h ago';
  }

  @override
  String time_days_ago(int n) {
    return '${n}d ago';
  }
}
