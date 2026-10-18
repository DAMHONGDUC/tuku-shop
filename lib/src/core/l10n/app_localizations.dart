import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Tuku Shop'**
  String get app_name;

  /// No description provided for @splash_description.
  ///
  /// In en, this message translates to:
  /// **'Any shopping just from home'**
  String get splash_description;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get login_title;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue shopping'**
  String get login_subtitle;

  /// No description provided for @login_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_email_label;

  /// No description provided for @login_email_hint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get login_email_hint;

  /// No description provided for @login_password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password_label;

  /// No description provided for @login_password_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get login_password_hint;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_button;

  /// No description provided for @login_signing_in.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get login_signing_in;

  /// No description provided for @login_no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_no_account;

  /// No description provided for @login_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get login_register;

  /// No description provided for @login_demo_title.
  ///
  /// In en, this message translates to:
  /// **'Demo account'**
  String get login_demo_title;

  /// No description provided for @login_demo_fill.
  ///
  /// In en, this message translates to:
  /// **'Use demo account'**
  String get login_demo_fill;

  /// No description provided for @login_error_email_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get login_error_email_empty;

  /// No description provided for @login_error_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get login_error_email_invalid;

  /// No description provided for @login_error_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get login_error_password_empty;

  /// No description provided for @login_error_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get login_error_invalid_credentials;

  /// No description provided for @login_error_unknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again'**
  String get login_error_unknown;

  /// No description provided for @logout_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not log out. Please try again'**
  String get logout_failed;

  /// No description provided for @common_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get common_retry;

  /// No description provided for @common_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load this. Check your connection and try again.'**
  String get common_load_failed;

  /// No description provided for @common_see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get common_see_all;

  /// No description provided for @common_items_count.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String common_items_count(int count);

  /// No description provided for @common_start_shopping.
  ///
  /// In en, this message translates to:
  /// **'Start shopping'**
  String get common_start_shopping;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get nav_categories;

  /// No description provided for @nav_wishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get nav_wishlist;

  /// No description provided for @nav_cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get nav_cart;

  /// No description provided for @nav_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get nav_profile;

  /// No description provided for @home_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search dresses, jeans…'**
  String get home_search_hint;

  /// No description provided for @home_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get home_categories;

  /// No description provided for @home_flash_sale.
  ///
  /// In en, this message translates to:
  /// **'Flash sale'**
  String get home_flash_sale;

  /// No description provided for @home_new_arrivals.
  ///
  /// In en, this message translates to:
  /// **'New arrivals'**
  String get home_new_arrivals;

  /// No description provided for @home_best_sellers.
  ///
  /// In en, this message translates to:
  /// **'Best sellers'**
  String get home_best_sellers;

  /// No description provided for @home_just_for_you.
  ///
  /// In en, this message translates to:
  /// **'Just for you'**
  String get home_just_for_you;

  /// No description provided for @categories_title.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories_title;

  /// No description provided for @products_count.
  ///
  /// In en, this message translates to:
  /// **'{count} products'**
  String products_count(int count);

  /// No description provided for @sort_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get sort_recommended;

  /// No description provided for @sort_newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get sort_newest;

  /// No description provided for @sort_price_low.
  ///
  /// In en, this message translates to:
  /// **'Price: low to high'**
  String get sort_price_low;

  /// No description provided for @sort_price_high.
  ///
  /// In en, this message translates to:
  /// **'Price: high to low'**
  String get sort_price_high;

  /// No description provided for @sort_rating.
  ///
  /// In en, this message translates to:
  /// **'Top rated'**
  String get sort_rating;

  /// No description provided for @filter_on_sale.
  ///
  /// In en, this message translates to:
  /// **'On sale'**
  String get filter_on_sale;

  /// No description provided for @products_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get products_empty_title;

  /// No description provided for @products_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Try another filter or category.'**
  String get products_empty_message;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search products'**
  String get search_hint;

  /// No description provided for @search_recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get search_recent;

  /// No description provided for @search_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get search_clear;

  /// No description provided for @search_trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get search_trending;

  /// No description provided for @search_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get search_recommended;

  /// No description provided for @search_no_results_title.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get search_no_results_title;

  /// No description provided for @search_no_results_message.
  ///
  /// In en, this message translates to:
  /// **'Check the spelling or try a broader word, like \"dress\" or \"jeans\".'**
  String get search_no_results_message;

  /// No description provided for @badge_new.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get badge_new;

  /// No description provided for @badge_discount.
  ///
  /// In en, this message translates to:
  /// **'-{percent}%'**
  String badge_discount(int percent);

  /// No description provided for @pdp_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get pdp_color;

  /// No description provided for @pdp_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get pdp_size;

  /// No description provided for @pdp_only_left.
  ///
  /// In en, this message translates to:
  /// **'Only {count} left'**
  String pdp_only_left(int count);

  /// No description provided for @pdp_sold_out.
  ///
  /// In en, this message translates to:
  /// **'Sold out'**
  String get pdp_sold_out;

  /// No description provided for @pdp_select_size.
  ///
  /// In en, this message translates to:
  /// **'Pick a size first'**
  String get pdp_select_size;

  /// No description provided for @pdp_free_shipping.
  ///
  /// In en, this message translates to:
  /// **'Free shipping'**
  String get pdp_free_shipping;

  /// No description provided for @pdp_free_shipping_sub.
  ///
  /// In en, this message translates to:
  /// **'over \$100'**
  String get pdp_free_shipping_sub;

  /// No description provided for @pdp_delivery.
  ///
  /// In en, this message translates to:
  /// **'2–4 days'**
  String get pdp_delivery;

  /// No description provided for @pdp_delivery_sub.
  ///
  /// In en, this message translates to:
  /// **'delivery'**
  String get pdp_delivery_sub;

  /// No description provided for @pdp_returns.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get pdp_returns;

  /// No description provided for @pdp_returns_sub.
  ///
  /// In en, this message translates to:
  /// **'free returns'**
  String get pdp_returns_sub;

  /// No description provided for @pdp_details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get pdp_details;

  /// No description provided for @pdp_material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get pdp_material;

  /// No description provided for @pdp_fit.
  ///
  /// In en, this message translates to:
  /// **'Fit'**
  String get pdp_fit;

  /// No description provided for @pdp_reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get pdp_reviews;

  /// No description provided for @pdp_reviews_count.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String pdp_reviews_count(int count);

  /// No description provided for @pdp_show_more_reviews.
  ///
  /// In en, this message translates to:
  /// **'Show more reviews'**
  String get pdp_show_more_reviews;

  /// No description provided for @pdp_related.
  ///
  /// In en, this message translates to:
  /// **'You may also like'**
  String get pdp_related;

  /// No description provided for @pdp_add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get pdp_add_to_cart;

  /// No description provided for @pdp_buy_now.
  ///
  /// In en, this message translates to:
  /// **'Buy now'**
  String get pdp_buy_now;

  /// No description provided for @pdp_sold.
  ///
  /// In en, this message translates to:
  /// **'{count} sold'**
  String pdp_sold(int count);

  /// No description provided for @wishlist_title.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist_title;

  /// No description provided for @wishlist_title_count.
  ///
  /// In en, this message translates to:
  /// **'Wishlist ({count})'**
  String wishlist_title_count(int count);

  /// No description provided for @wishlist_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Save what you love'**
  String get wishlist_empty_title;

  /// No description provided for @wishlist_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on any item to keep it here for later.'**
  String get wishlist_empty_message;

  /// No description provided for @cart_title.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart_title;

  /// No description provided for @cart_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cart_empty_title;

  /// No description provided for @cart_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Find something you like and add it here.'**
  String get cart_empty_message;

  /// No description provided for @notifications_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_title;

  /// No description provided for @common_undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get common_undo;

  /// No description provided for @cart_title_count.
  ///
  /// In en, this message translates to:
  /// **'Cart ({count})'**
  String cart_title_count(int count);

  /// No description provided for @cart_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update your cart. Try again.'**
  String get cart_update_failed;

  /// No description provided for @cart_free_shipping_unlocked.
  ///
  /// In en, this message translates to:
  /// **'You\'ve unlocked free standard shipping 🎉'**
  String get cart_free_shipping_unlocked;

  /// No description provided for @cart_free_shipping_nudge.
  ///
  /// In en, this message translates to:
  /// **'Add {amount} more for free shipping'**
  String cart_free_shipping_nudge(String amount);

  /// No description provided for @cart_subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cart_subtotal;

  /// No description provided for @cart_savings.
  ///
  /// In en, this message translates to:
  /// **'You save'**
  String get cart_savings;

  /// No description provided for @cart_shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get cart_shipping;

  /// No description provided for @cart_shipping_at_checkout.
  ///
  /// In en, this message translates to:
  /// **'At checkout'**
  String get cart_shipping_at_checkout;

  /// No description provided for @cart_removed.
  ///
  /// In en, this message translates to:
  /// **'Removed {name}'**
  String cart_removed(String name);

  /// No description provided for @cart_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get cart_remove;

  /// No description provided for @cart_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cart_total;

  /// No description provided for @cart_checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get cart_checkout;

  /// No description provided for @pdp_added_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get pdp_added_to_cart;

  /// No description provided for @pdp_view_cart.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get pdp_view_cart;

  /// No description provided for @pdp_add_failed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t add to cart. Try again.'**
  String get pdp_add_failed;

  /// No description provided for @sheet_in_stock.
  ///
  /// In en, this message translates to:
  /// **'{count} in stock'**
  String sheet_in_stock(int count);

  /// No description provided for @sheet_quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get sheet_quantity;

  /// No description provided for @sheet_add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart · {total}'**
  String sheet_add_to_cart(String total);

  /// No description provided for @sheet_buy_now.
  ///
  /// In en, this message translates to:
  /// **'Buy now · {total}'**
  String sheet_buy_now(String total);

  /// No description provided for @checkout_title.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout_title;

  /// No description provided for @checkout_items_title.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get checkout_items_title;

  /// No description provided for @checkout_items.
  ///
  /// In en, this message translates to:
  /// **'Items ({count})'**
  String checkout_items(int count);

  /// No description provided for @checkout_ship_to.
  ///
  /// In en, this message translates to:
  /// **'Ship to'**
  String get checkout_ship_to;

  /// No description provided for @checkout_change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get checkout_change;

  /// No description provided for @checkout_no_address.
  ///
  /// In en, this message translates to:
  /// **'Add an address to continue'**
  String get checkout_no_address;

  /// No description provided for @checkout_shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get checkout_shipping;

  /// No description provided for @checkout_shipping_days.
  ///
  /// In en, this message translates to:
  /// **'{min}–{max} days'**
  String checkout_shipping_days(int min, int max);

  /// No description provided for @checkout_free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get checkout_free;

  /// No description provided for @checkout_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get checkout_payment;

  /// No description provided for @checkout_voucher.
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get checkout_voucher;

  /// No description provided for @checkout_voucher_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter a code'**
  String get checkout_voucher_hint;

  /// No description provided for @checkout_voucher_invalid.
  ///
  /// In en, this message translates to:
  /// **'This code isn\'t valid'**
  String get checkout_voucher_invalid;

  /// No description provided for @checkout_voucher_try.
  ///
  /// In en, this message translates to:
  /// **'Try TUKU10 for 10% off or FREESHIP'**
  String get checkout_voucher_try;

  /// No description provided for @checkout_voucher_percent.
  ///
  /// In en, this message translates to:
  /// **'{code} · {percent}% off'**
  String checkout_voucher_percent(String code, int percent);

  /// No description provided for @checkout_voucher_free_shipping.
  ///
  /// In en, this message translates to:
  /// **'{code} · free standard shipping'**
  String checkout_voucher_free_shipping(String code);

  /// No description provided for @checkout_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get checkout_apply;

  /// No description provided for @checkout_summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get checkout_summary;

  /// No description provided for @checkout_discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get checkout_discount;

  /// No description provided for @checkout_place_order.
  ///
  /// In en, this message translates to:
  /// **'Place order · {total}'**
  String checkout_place_order(String total);

  /// No description provided for @checkout_place_failed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t place the order. Try again.'**
  String get checkout_place_failed;

  /// No description provided for @success_title.
  ///
  /// In en, this message translates to:
  /// **'Order placed!'**
  String get success_title;

  /// No description provided for @success_message.
  ///
  /// In en, this message translates to:
  /// **'Thanks for shopping with us. We\'ll let you know when it ships.'**
  String get success_message;

  /// No description provided for @success_order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get success_order;

  /// No description provided for @success_arrives.
  ///
  /// In en, this message translates to:
  /// **'Arrives by'**
  String get success_arrives;

  /// No description provided for @success_track.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get success_track;

  /// No description provided for @success_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue shopping'**
  String get success_continue;

  /// No description provided for @address_book_title.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get address_book_title;

  /// No description provided for @address_pick_title.
  ///
  /// In en, this message translates to:
  /// **'Choose an address'**
  String get address_pick_title;

  /// No description provided for @address_add.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get address_add;

  /// No description provided for @address_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit address'**
  String get address_edit;

  /// No description provided for @address_default.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get address_default;

  /// No description provided for @address_set_default.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get address_set_default;

  /// No description provided for @address_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get address_delete;

  /// No description provided for @address_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No addresses yet'**
  String get address_empty_title;

  /// No description provided for @address_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Add where you\'d like your orders delivered.'**
  String get address_empty_message;

  /// No description provided for @address_full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get address_full_name;

  /// No description provided for @address_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get address_phone;

  /// No description provided for @address_street.
  ///
  /// In en, this message translates to:
  /// **'Street and number'**
  String get address_street;

  /// No description provided for @address_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get address_city;

  /// No description provided for @address_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get address_state;

  /// No description provided for @address_postal_code.
  ///
  /// In en, this message translates to:
  /// **'Postal code'**
  String get address_postal_code;

  /// No description provided for @address_make_default.
  ///
  /// In en, this message translates to:
  /// **'Use as my default address'**
  String get address_make_default;

  /// No description provided for @address_save.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get address_save;

  /// No description provided for @address_save_failed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the address. Try again.'**
  String get address_save_failed;

  /// No description provided for @address_field_invalid.
  ///
  /// In en, this message translates to:
  /// **'Check this field'**
  String get address_field_invalid;

  /// No description provided for @orders_title.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get orders_title;

  /// No description provided for @orders_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No orders here'**
  String get orders_empty_title;

  /// No description provided for @orders_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Orders in this status will show up here.'**
  String get orders_empty_message;

  /// No description provided for @order_status_to_confirm.
  ///
  /// In en, this message translates to:
  /// **'To confirm'**
  String get order_status_to_confirm;

  /// No description provided for @order_status_to_ship.
  ///
  /// In en, this message translates to:
  /// **'To ship'**
  String get order_status_to_ship;

  /// No description provided for @order_status_on_the_way.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get order_status_on_the_way;

  /// No description provided for @order_status_delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get order_status_delivered;

  /// No description provided for @order_status_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get order_status_cancelled;

  /// No description provided for @order_status_returned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get order_status_returned;

  /// No description provided for @order_headline_to_confirm.
  ///
  /// In en, this message translates to:
  /// **'We\'ve received your order'**
  String get order_headline_to_confirm;

  /// No description provided for @order_headline_to_ship.
  ///
  /// In en, this message translates to:
  /// **'Your order is being packed'**
  String get order_headline_to_ship;

  /// No description provided for @order_headline_on_the_way.
  ///
  /// In en, this message translates to:
  /// **'Your order is on the way'**
  String get order_headline_on_the_way;

  /// No description provided for @order_headline_delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered. Enjoy!'**
  String get order_headline_delivered;

  /// No description provided for @order_headline_cancelled.
  ///
  /// In en, this message translates to:
  /// **'This order was cancelled'**
  String get order_headline_cancelled;

  /// No description provided for @order_headline_returned.
  ///
  /// In en, this message translates to:
  /// **'This order was returned'**
  String get order_headline_returned;

  /// No description provided for @order_eta.
  ///
  /// In en, this message translates to:
  /// **'Estimated delivery {date}'**
  String order_eta(String date);

  /// No description provided for @order_more_items.
  ///
  /// In en, this message translates to:
  /// **'+{count} more items'**
  String order_more_items(int count);

  /// No description provided for @order_items_total.
  ///
  /// In en, this message translates to:
  /// **'{count} items · total'**
  String order_items_total(int count);

  /// No description provided for @order_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel order'**
  String get order_cancel;

  /// No description provided for @order_cancel_title.
  ///
  /// In en, this message translates to:
  /// **'Cancel this order?'**
  String get order_cancel_title;

  /// No description provided for @order_cancel_message.
  ///
  /// In en, this message translates to:
  /// **'We haven\'t confirmed it yet, so nothing will be charged.'**
  String get order_cancel_message;

  /// No description provided for @order_cancel_keep.
  ///
  /// In en, this message translates to:
  /// **'Keep order'**
  String get order_cancel_keep;

  /// No description provided for @order_cancel_confirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel order'**
  String get order_cancel_confirm;

  /// No description provided for @order_cancelled_toast.
  ///
  /// In en, this message translates to:
  /// **'Order cancelled'**
  String get order_cancelled_toast;

  /// No description provided for @order_buy_again.
  ///
  /// In en, this message translates to:
  /// **'Buy again'**
  String get order_buy_again;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
