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

  /// No description provided for @error_title.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_title;

  /// No description provided for @error_message.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load this right now. Check your connection and try again.'**
  String get error_message;

  /// No description provided for @action_retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get action_retry;

  /// No description provided for @tab_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tab_home;

  /// No description provided for @tab_shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get tab_shop;

  /// No description provided for @tab_wishlist.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get tab_wishlist;

  /// No description provided for @tab_bag.
  ///
  /// In en, this message translates to:
  /// **'Bag'**
  String get tab_bag;

  /// No description provided for @tab_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tab_profile;

  /// No description provided for @splash_tagline.
  ///
  /// In en, this message translates to:
  /// **'Wear what moves you'**
  String get splash_tagline;

  /// No description provided for @action_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get action_skip;

  /// No description provided for @action_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get action_next;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Dress for\nthe way you move'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_body_1.
  ///
  /// In en, this message translates to:
  /// **'Performance pieces and everyday layers, picked for comfort that lasts from the studio to the street.'**
  String get onboarding_body_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Discover\nyour style'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_body_2.
  ///
  /// In en, this message translates to:
  /// **'Browse new arrivals, curated edits and members-only drops — all in one place.'**
  String get onboarding_body_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Fast delivery,\neasy returns'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_body_3.
  ///
  /// In en, this message translates to:
  /// **'Free shipping over \$75, live order tracking and 30-day returns. Shopping, simplified.'**
  String get onboarding_body_3;

  /// No description provided for @onboarding_start.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboarding_start;

  /// No description provided for @action_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get action_close;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get login_title;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to pick up where you left off.'**
  String get login_subtitle;

  /// No description provided for @login_demo_title.
  ///
  /// In en, this message translates to:
  /// **'Demo account'**
  String get login_demo_title;

  /// No description provided for @login_demo_fill.
  ///
  /// In en, this message translates to:
  /// **'Fill'**
  String get login_demo_fill;

  /// No description provided for @field_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get field_email;

  /// No description provided for @field_email_hint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get field_email_hint;

  /// No description provided for @field_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get field_password;

  /// No description provided for @password_show.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get password_show;

  /// No description provided for @password_hide.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get password_hide;

  /// No description provided for @login_remember.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get login_remember;

  /// No description provided for @login_forgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get login_forgot;

  /// No description provided for @login_submit.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_submit;

  /// No description provided for @login_or.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get login_or;

  /// No description provided for @login_social_demo.
  ///
  /// In en, this message translates to:
  /// **'Social sign-in is off in this demo — use the demo account.'**
  String get login_social_demo;

  /// No description provided for @login_no_account.
  ///
  /// In en, this message translates to:
  /// **'New to Tuku?'**
  String get login_no_account;

  /// No description provided for @login_create_account.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get login_create_account;

  /// No description provided for @forgot_title.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get forgot_title;

  /// No description provided for @forgot_body.
  ///
  /// In en, this message translates to:
  /// **'Enter the email you signed up with and we\'ll send you a link to choose a new password.'**
  String get forgot_body;

  /// No description provided for @forgot_submit.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get forgot_submit;

  /// No description provided for @forgot_sent.
  ///
  /// In en, this message translates to:
  /// **'Reset link sent to {email}'**
  String forgot_sent(String email);

  /// No description provided for @validation_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validation_required;

  /// No description provided for @validation_email.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validation_email;

  /// No description provided for @validation_password_short.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get validation_password_short;

  /// No description provided for @validation_password_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get validation_password_mismatch;

  /// No description provided for @auth_error_credentials.
  ///
  /// In en, this message translates to:
  /// **'That email and password don\'t match. Try the demo account.'**
  String get auth_error_credentials;

  /// No description provided for @auth_error_email_taken.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get auth_error_email_taken;

  /// No description provided for @register_title.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get register_title;

  /// No description provided for @register_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Join Tuku for members-only prices, faster checkout and order tracking.'**
  String get register_subtitle;

  /// No description provided for @field_full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get field_full_name;

  /// No description provided for @field_full_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Alex Morgan'**
  String get field_full_name_hint;

  /// No description provided for @field_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get field_confirm_password;

  /// No description provided for @register_terms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy'**
  String get register_terms;

  /// No description provided for @register_accept_terms.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms to continue'**
  String get register_accept_terms;

  /// No description provided for @register_submit.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get register_submit;

  /// No description provided for @register_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already a member?'**
  String get register_have_account;

  /// No description provided for @register_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Tuku! 200 points added to your account.'**
  String get register_welcome;

  /// No description provided for @password_weak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get password_weak;

  /// No description provided for @password_fair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get password_fair;

  /// No description provided for @password_good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get password_good;

  /// No description provided for @password_strong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get password_strong;

  /// No description provided for @action_shop_now.
  ///
  /// In en, this message translates to:
  /// **'Shop now'**
  String get action_shop_now;

  /// No description provided for @action_see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get action_see_all;

  /// No description provided for @home_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get home_categories;

  /// No description provided for @badge_new.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get badge_new;

  /// No description provided for @wishlist_add.
  ///
  /// In en, this message translates to:
  /// **'Save to wishlist'**
  String get wishlist_add;

  /// No description provided for @wishlist_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove from wishlist'**
  String get wishlist_remove;

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

  /// No description provided for @sort_top_rated.
  ///
  /// In en, this message translates to:
  /// **'Top rated'**
  String get sort_top_rated;

  /// No description provided for @sort_best_selling.
  ///
  /// In en, this message translates to:
  /// **'Best selling'**
  String get sort_best_selling;

  /// No description provided for @gender_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get gender_all;

  /// No description provided for @gender_men.
  ///
  /// In en, this message translates to:
  /// **'Men'**
  String get gender_men;

  /// No description provided for @gender_women.
  ///
  /// In en, this message translates to:
  /// **'Women'**
  String get gender_women;

  /// No description provided for @gender_unisex.
  ///
  /// In en, this message translates to:
  /// **'Unisex'**
  String get gender_unisex;

  /// No description provided for @home_flash_sale.
  ///
  /// In en, this message translates to:
  /// **'Flash sale'**
  String get home_flash_sale;

  /// No description provided for @home_flash_sale_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Deepest markdowns, for a few hours only'**
  String get home_flash_sale_subtitle;

  /// No description provided for @home_flash_sale_all.
  ///
  /// In en, this message translates to:
  /// **'Shop the whole sale'**
  String get home_flash_sale_all;

  /// No description provided for @home_flash_sale_ends.
  ///
  /// In en, this message translates to:
  /// **'Sale ends in {time}'**
  String home_flash_sale_ends(String time);

  /// No description provided for @home_recommended.
  ///
  /// In en, this message translates to:
  /// **'Picked for you'**
  String get home_recommended;

  /// No description provided for @home_recommended_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on what\'s trending this week'**
  String get home_recommended_subtitle;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search hoodies, leggings, bags…'**
  String get search_hint;

  /// No description provided for @home_greeting_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get home_greeting_morning;

  /// No description provided for @home_greeting_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get home_greeting_afternoon;

  /// No description provided for @home_greeting_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get home_greeting_evening;

  /// No description provided for @home_guest.
  ///
  /// In en, this message translates to:
  /// **'there'**
  String get home_guest;

  /// No description provided for @notifications_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_title;

  /// No description provided for @perk_shipping.
  ///
  /// In en, this message translates to:
  /// **'Free shipping\nover \$75'**
  String get perk_shipping;

  /// No description provided for @perk_returns.
  ///
  /// In en, this message translates to:
  /// **'30-day\nreturns'**
  String get perk_returns;

  /// No description provided for @perk_secure.
  ///
  /// In en, this message translates to:
  /// **'Secure\ncheckout'**
  String get perk_secure;

  /// No description provided for @home_new_arrivals.
  ///
  /// In en, this message translates to:
  /// **'New arrivals'**
  String get home_new_arrivals;

  /// No description provided for @home_new_arrivals_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh drops this week'**
  String get home_new_arrivals_subtitle;

  /// No description provided for @home_best_sellers.
  ///
  /// In en, this message translates to:
  /// **'Best sellers'**
  String get home_best_sellers;

  /// No description provided for @home_lookbook.
  ///
  /// In en, this message translates to:
  /// **'Shop the look'**
  String get home_lookbook;

  /// No description provided for @home_lookbook_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Edits from our studio'**
  String get home_lookbook_subtitle;

  /// No description provided for @home_look_women.
  ///
  /// In en, this message translates to:
  /// **'Studio to street'**
  String get home_look_women;

  /// No description provided for @home_look_men.
  ///
  /// In en, this message translates to:
  /// **'Built for the coast'**
  String get home_look_men;

  /// No description provided for @home_look_performance.
  ///
  /// In en, this message translates to:
  /// **'Performance edit'**
  String get home_look_performance;

  /// No description provided for @home_look_performance_caption.
  ///
  /// In en, this message translates to:
  /// **'Our highest-rated pieces'**
  String get home_look_performance_caption;

  /// No description provided for @browse_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches yet'**
  String get browse_empty_title;

  /// No description provided for @browse_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Try a different category or loosen your filters.'**
  String get browse_empty_message;

  /// No description provided for @browse_end.
  ///
  /// In en, this message translates to:
  /// **'That\'s all {count} pieces'**
  String browse_end(int count);

  /// No description provided for @browse_all_categories.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get browse_all_categories;

  /// No description provided for @browse_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get browse_loading;

  /// No description provided for @browse_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String browse_count(int count);

  /// No description provided for @sort_title.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sort_title;

  /// No description provided for @filter_title.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filter_title;

  /// No description provided for @filter_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get filter_reset;

  /// No description provided for @filter_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get filter_clear;

  /// No description provided for @filter_apply.
  ///
  /// In en, this message translates to:
  /// **'Show results'**
  String get filter_apply;

  /// No description provided for @filter_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get filter_price;

  /// No description provided for @filter_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get filter_size;

  /// No description provided for @filter_color.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get filter_color;

  /// No description provided for @filter_on_sale.
  ///
  /// In en, this message translates to:
  /// **'On sale only'**
  String get filter_on_sale;

  /// No description provided for @filter_new_only.
  ///
  /// In en, this message translates to:
  /// **'New arrivals only'**
  String get filter_new_only;

  /// No description provided for @shop_title.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop_title;

  /// No description provided for @search_title.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_title;

  /// No description provided for @search_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get search_clear;

  /// No description provided for @search_recent.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get search_recent;

  /// No description provided for @search_clear_recent.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get search_clear_recent;

  /// No description provided for @search_trending.
  ///
  /// In en, this message translates to:
  /// **'Trending now'**
  String get search_trending;

  /// No description provided for @action_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get action_share;

  /// No description provided for @action_decrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get action_decrease;

  /// No description provided for @action_increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get action_increase;

  /// No description provided for @detail_link_copied.
  ///
  /// In en, this message translates to:
  /// **'Product link copied'**
  String get detail_link_copied;

  /// No description provided for @detail_related.
  ///
  /// In en, this message translates to:
  /// **'You may also like'**
  String get detail_related;

  /// No description provided for @badge_eco.
  ///
  /// In en, this message translates to:
  /// **'Eco'**
  String get badge_eco;

  /// No description provided for @badge_best_seller.
  ///
  /// In en, this message translates to:
  /// **'Best seller'**
  String get badge_best_seller;

  /// No description provided for @detail_rating.
  ///
  /// In en, this message translates to:
  /// **'Rated {rating} out of 5'**
  String detail_rating(String rating);

  /// No description provided for @detail_reviews.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 review} other{{count} reviews}}'**
  String detail_reviews(int count);

  /// No description provided for @detail_sold.
  ///
  /// In en, this message translates to:
  /// **'{sold} sold'**
  String detail_sold(String sold);

  /// No description provided for @detail_save.
  ///
  /// In en, this message translates to:
  /// **'Save {amount}'**
  String detail_save(String amount);

  /// No description provided for @detail_color.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get detail_color;

  /// No description provided for @detail_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get detail_size;

  /// No description provided for @detail_size_pick.
  ///
  /// In en, this message translates to:
  /// **'Pick a size'**
  String get detail_size_pick;

  /// No description provided for @detail_size_guide.
  ///
  /// In en, this message translates to:
  /// **'Size guide'**
  String get detail_size_guide;

  /// No description provided for @detail_quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get detail_quantity;

  /// No description provided for @size_guide_tops.
  ///
  /// In en, this message translates to:
  /// **'Body measurements in inches. Between sizes? Size up for a relaxed fit.'**
  String get size_guide_tops;

  /// No description provided for @size_guide_bottoms.
  ///
  /// In en, this message translates to:
  /// **'Waist measurement in inches.'**
  String get size_guide_bottoms;

  /// No description provided for @size_guide_note.
  ///
  /// In en, this message translates to:
  /// **'Free exchanges within 30 days if the fit isn\'t right.'**
  String get size_guide_note;

  /// No description provided for @size_chest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get size_chest;

  /// No description provided for @size_waist.
  ///
  /// In en, this message translates to:
  /// **'Waist'**
  String get size_waist;

  /// No description provided for @size_hips.
  ///
  /// In en, this message translates to:
  /// **'Hips'**
  String get size_hips;

  /// No description provided for @detail_perk_shipping.
  ///
  /// In en, this message translates to:
  /// **'Free delivery over \$75'**
  String get detail_perk_shipping;

  /// No description provided for @detail_perk_shipping_sub.
  ///
  /// In en, this message translates to:
  /// **'Arrives in 3–5 business days'**
  String get detail_perk_shipping_sub;

  /// No description provided for @detail_perk_returns.
  ///
  /// In en, this message translates to:
  /// **'Free 30-day returns'**
  String get detail_perk_returns;

  /// No description provided for @detail_perk_returns_sub.
  ///
  /// In en, this message translates to:
  /// **'Not the right fit? Send it back on us'**
  String get detail_perk_returns_sub;

  /// No description provided for @detail_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get detail_description;

  /// No description provided for @detail_material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get detail_material;

  /// No description provided for @detail_read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get detail_read_more;

  /// No description provided for @detail_read_less.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get detail_read_less;

  /// No description provided for @review_variant.
  ///
  /// In en, this message translates to:
  /// **'Size {size} · {color}'**
  String review_variant(String color, String size);

  /// No description provided for @review_helpful.
  ///
  /// In en, this message translates to:
  /// **'{count} found this helpful'**
  String review_helpful(int count);

  /// No description provided for @detail_reviews_title.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get detail_reviews_title;

  /// No description provided for @detail_all_reviews.
  ///
  /// In en, this message translates to:
  /// **'Read all {count} reviews'**
  String detail_all_reviews(int count);

  /// No description provided for @detail_choose_size.
  ///
  /// In en, this message translates to:
  /// **'Choose a size first'**
  String get detail_choose_size;

  /// No description provided for @detail_added.
  ///
  /// In en, this message translates to:
  /// **'Added to your bag'**
  String get detail_added;

  /// No description provided for @detail_view_bag.
  ///
  /// In en, this message translates to:
  /// **'View bag'**
  String get detail_view_bag;

  /// No description provided for @detail_add_to_bag.
  ///
  /// In en, this message translates to:
  /// **'Add to bag'**
  String get detail_add_to_bag;

  /// No description provided for @reviews_empty.
  ///
  /// In en, this message translates to:
  /// **'No reviews with this rating yet'**
  String get reviews_empty;

  /// No description provided for @wishlist_title.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get wishlist_title;

  /// No description provided for @wishlist_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Nothing saved yet} =1{1 piece saved} other{{count} pieces saved}}'**
  String wishlist_count(int count);

  /// No description provided for @wishlist_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Your wishlist is empty'**
  String get wishlist_empty_title;

  /// No description provided for @wishlist_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on anything you love and it\'ll wait for you here.'**
  String get wishlist_empty_message;

  /// No description provided for @wishlist_move_to_bag.
  ///
  /// In en, this message translates to:
  /// **'Add to bag'**
  String get wishlist_move_to_bag;

  /// No description provided for @action_start_shopping.
  ///
  /// In en, this message translates to:
  /// **'Start shopping'**
  String get action_start_shopping;
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
