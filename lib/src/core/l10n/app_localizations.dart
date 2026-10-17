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

  /// No description provided for @cart_title.
  ///
  /// In en, this message translates to:
  /// **'Bag'**
  String get cart_title;

  /// No description provided for @cart_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String cart_count(int count);

  /// No description provided for @cart_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Your bag is empty'**
  String get cart_empty_title;

  /// No description provided for @cart_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Everything you add will show up here, ready for checkout.'**
  String get cart_empty_message;

  /// No description provided for @cart_removed.
  ///
  /// In en, this message translates to:
  /// **'Removed {name}'**
  String cart_removed(String name);

  /// No description provided for @cart_checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get cart_checkout;

  /// No description provided for @cart_free_shipping_unlocked.
  ///
  /// In en, this message translates to:
  /// **'You\'ve unlocked free shipping'**
  String get cart_free_shipping_unlocked;

  /// No description provided for @cart_free_shipping_more.
  ///
  /// In en, this message translates to:
  /// **'Add {amount} more for free shipping'**
  String cart_free_shipping_more(String amount);

  /// No description provided for @action_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get action_remove;

  /// No description provided for @action_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get action_apply;

  /// No description provided for @promo_label.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get promo_label;

  /// No description provided for @promo_hint.
  ///
  /// In en, this message translates to:
  /// **'Try TUKU10'**
  String get promo_hint;

  /// No description provided for @promo_applied.
  ///
  /// In en, this message translates to:
  /// **'Promo code applied'**
  String get promo_applied;

  /// No description provided for @promo_error_invalid.
  ///
  /// In en, this message translates to:
  /// **'That code isn\'t valid. Try TUKU10, WELCOME20 or FREESHIP.'**
  String get promo_error_invalid;

  /// No description provided for @promo_error_minimum.
  ///
  /// In en, this message translates to:
  /// **'This code needs a subtotal of \$100 or more.'**
  String get promo_error_minimum;

  /// No description provided for @promo_free_shipping.
  ///
  /// In en, this message translates to:
  /// **'Free shipping'**
  String get promo_free_shipping;

  /// No description provided for @promo_percent_off.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off your order'**
  String promo_percent_off(int percent);

  /// No description provided for @summary_subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get summary_subtotal;

  /// No description provided for @summary_discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get summary_discount;

  /// No description provided for @summary_shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get summary_shipping;

  /// No description provided for @summary_free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get summary_free;

  /// No description provided for @summary_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get summary_total;

  /// No description provided for @summary_savings.
  ///
  /// In en, this message translates to:
  /// **'You save {amount}'**
  String summary_savings(String amount);

  /// No description provided for @checkout_title.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout_title;

  /// No description provided for @checkout_address.
  ///
  /// In en, this message translates to:
  /// **'Shipping address'**
  String get checkout_address;

  /// No description provided for @checkout_delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get checkout_delivery;

  /// No description provided for @checkout_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get checkout_payment;

  /// No description provided for @checkout_items.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String checkout_items(int count);

  /// No description provided for @checkout_place_order.
  ///
  /// In en, this message translates to:
  /// **'Place order'**
  String get checkout_place_order;

  /// No description provided for @checkout_secure_note.
  ///
  /// In en, this message translates to:
  /// **'Payments are encrypted. This demo never charges a real card.'**
  String get checkout_secure_note;

  /// No description provided for @checkout_failed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t place your order. Please try again.'**
  String get checkout_failed;

  /// No description provided for @action_change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get action_change;

  /// No description provided for @address_add.
  ///
  /// In en, this message translates to:
  /// **'Add a new address'**
  String get address_add;

  /// No description provided for @delivery_standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get delivery_standard;

  /// No description provided for @delivery_express.
  ///
  /// In en, this message translates to:
  /// **'Express'**
  String get delivery_express;

  /// No description provided for @delivery_next_day.
  ///
  /// In en, this message translates to:
  /// **'Next day'**
  String get delivery_next_day;

  /// No description provided for @delivery_eta_range.
  ///
  /// In en, this message translates to:
  /// **'Arrives {from} – {to}'**
  String delivery_eta_range(String from, String to);

  /// No description provided for @delivery_eta_single.
  ///
  /// In en, this message translates to:
  /// **'Arrives {date}'**
  String delivery_eta_single(String date);

  /// No description provided for @payment_cod.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get payment_cod;

  /// No description provided for @success_title.
  ///
  /// In en, this message translates to:
  /// **'Order placed!'**
  String get success_title;

  /// No description provided for @success_message.
  ///
  /// In en, this message translates to:
  /// **'Thank you for shopping with Tuku. We\'ve emailed your receipt and will let you know when it ships.'**
  String get success_message;

  /// No description provided for @success_order_number.
  ///
  /// In en, this message translates to:
  /// **'Order number'**
  String get success_order_number;

  /// No description provided for @success_eta.
  ///
  /// In en, this message translates to:
  /// **'Estimated delivery'**
  String get success_eta;

  /// No description provided for @success_track.
  ///
  /// In en, this message translates to:
  /// **'Track my order'**
  String get success_track;

  /// No description provided for @success_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue shopping'**
  String get success_continue;

  /// No description provided for @action_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get action_cancel;

  /// No description provided for @addresses_title.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addresses_title;

  /// No description provided for @addresses_empty.
  ///
  /// In en, this message translates to:
  /// **'No saved addresses yet'**
  String get addresses_empty;

  /// No description provided for @address_default.
  ///
  /// In en, this message translates to:
  /// **'DEFAULT'**
  String get address_default;

  /// No description provided for @address_make_default.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get address_make_default;

  /// No description provided for @address_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete this address?'**
  String get address_delete_title;

  /// No description provided for @address_new_title.
  ///
  /// In en, this message translates to:
  /// **'New address'**
  String get address_new_title;

  /// No description provided for @address_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit address'**
  String get address_edit_title;

  /// No description provided for @address_saved.
  ///
  /// In en, this message translates to:
  /// **'Address saved'**
  String get address_saved;

  /// No description provided for @address_label.
  ///
  /// In en, this message translates to:
  /// **'Save as'**
  String get address_label;

  /// No description provided for @address_label_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get address_label_home;

  /// No description provided for @address_label_office.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get address_label_office;

  /// No description provided for @address_label_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get address_label_other;

  /// No description provided for @address_save.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get address_save;

  /// No description provided for @field_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get field_phone;

  /// No description provided for @field_street.
  ///
  /// In en, this message translates to:
  /// **'Street address'**
  String get field_street;

  /// No description provided for @field_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get field_city;

  /// No description provided for @field_postal.
  ///
  /// In en, this message translates to:
  /// **'Postal code'**
  String get field_postal;

  /// No description provided for @field_country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get field_country;

  /// No description provided for @payment_title.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get payment_title;

  /// No description provided for @payment_methods.
  ///
  /// In en, this message translates to:
  /// **'Saved methods'**
  String get payment_methods;

  /// No description provided for @payment_add_card.
  ///
  /// In en, this message translates to:
  /// **'Add a card'**
  String get payment_add_card;

  /// No description provided for @payment_add_demo.
  ///
  /// In en, this message translates to:
  /// **'Adding cards is off in this demo.'**
  String get payment_add_demo;

  /// No description provided for @orders_title.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get orders_title;

  /// No description provided for @orders_filter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get orders_filter_all;

  /// No description provided for @orders_filter_active.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get orders_filter_active;

  /// No description provided for @orders_filter_delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orders_filter_delivered;

  /// No description provided for @orders_filter_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orders_filter_cancelled;

  /// No description provided for @orders_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No orders here'**
  String get orders_empty_title;

  /// No description provided for @orders_empty_message.
  ///
  /// In en, this message translates to:
  /// **'When you place an order, you can follow it from here.'**
  String get orders_empty_message;

  /// No description provided for @order_status_placed.
  ///
  /// In en, this message translates to:
  /// **'Placed'**
  String get order_status_placed;

  /// No description provided for @order_status_processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get order_status_processing;

  /// No description provided for @order_status_shipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get order_status_shipped;

  /// No description provided for @order_status_out.
  ///
  /// In en, this message translates to:
  /// **'Out for delivery'**
  String get order_status_out;

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

  /// No description provided for @order_detail_title.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order_detail_title;

  /// No description provided for @order_shipping_info.
  ///
  /// In en, this message translates to:
  /// **'Delivery & payment'**
  String get order_shipping_info;

  /// No description provided for @order_tracking.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get order_tracking;

  /// No description provided for @order_delivered_on.
  ///
  /// In en, this message translates to:
  /// **'Delivered {date}'**
  String order_delivered_on(String date);

  /// No description provided for @order_arriving.
  ///
  /// In en, this message translates to:
  /// **'Arriving by {date}'**
  String order_arriving(String date);

  /// No description provided for @order_cancelled_note.
  ///
  /// In en, this message translates to:
  /// **'Refunded to your original payment method'**
  String get order_cancelled_note;

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
  /// **'It hasn\'t shipped yet, so you\'ll get a full refund.'**
  String get order_cancel_message;

  /// No description provided for @order_cancel_confirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, cancel it'**
  String get order_cancel_confirm;

  /// No description provided for @order_keep.
  ///
  /// In en, this message translates to:
  /// **'Keep my order'**
  String get order_keep;

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

  /// No description provided for @order_bought_again.
  ///
  /// In en, this message translates to:
  /// **'Items added to your bag'**
  String get order_bought_again;

  /// No description provided for @order_write_review.
  ///
  /// In en, this message translates to:
  /// **'Write a review'**
  String get order_write_review;

  /// No description provided for @order_review_thanks.
  ///
  /// In en, this message translates to:
  /// **'Reviews open in the full app — thanks for trying the demo!'**
  String get order_review_thanks;

  /// No description provided for @order_help.
  ///
  /// In en, this message translates to:
  /// **'Need help with this order?'**
  String get order_help;

  /// No description provided for @notifications_mark_all.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notifications_mark_all;

  /// No description provided for @notifications_empty.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get notifications_empty;

  /// No description provided for @notifications_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get notifications_today;

  /// No description provided for @notifications_earlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get notifications_earlier;

  /// No description provided for @time_minutes_ago.
  ///
  /// In en, this message translates to:
  /// **'{n}m ago'**
  String time_minutes_ago(int n);

  /// No description provided for @time_hours_ago.
  ///
  /// In en, this message translates to:
  /// **'{n}h ago'**
  String time_hours_ago(int n);

  /// No description provided for @time_days_ago.
  ///
  /// In en, this message translates to:
  /// **'{n}d ago'**
  String time_days_ago(int n);

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_member_since.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String profile_member_since(String date);

  /// No description provided for @profile_points_title.
  ///
  /// In en, this message translates to:
  /// **'Tuku Points'**
  String get profile_points_title;

  /// No description provided for @profile_points_hint.
  ///
  /// In en, this message translates to:
  /// **'1 point for every dollar you spend'**
  String get profile_points_hint;

  /// No description provided for @profile_points_value.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String profile_points_value(int points);

  /// No description provided for @profile_orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get profile_orders;

  /// No description provided for @profile_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get profile_saved;

  /// No description provided for @profile_section_shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get profile_section_shopping;

  /// No description provided for @profile_section_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profile_section_account;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profile_logout;

  /// No description provided for @profile_logout_title.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get profile_logout_title;

  /// No description provided for @profile_logout_message.
  ///
  /// In en, this message translates to:
  /// **'Your bag and saved pieces stay on this device.'**
  String get profile_logout_message;

  /// No description provided for @edit_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get edit_profile_title;

  /// No description provided for @edit_profile_save.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get edit_profile_save;

  /// No description provided for @edit_profile_saved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get edit_profile_saved;

  /// No description provided for @validation_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get validation_phone;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_appearance;

  /// No description provided for @settings_theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_light;

  /// No description provided for @settings_theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_dark;

  /// No description provided for @settings_theme_system.
  ///
  /// In en, this message translates to:
  /// **'Match system'**
  String get settings_theme_system;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_language_en;

  /// No description provided for @settings_language_vi.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get settings_language_vi;

  /// No description provided for @settings_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_notifications;

  /// No description provided for @settings_push.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settings_push;

  /// No description provided for @settings_push_hint.
  ///
  /// In en, this message translates to:
  /// **'Order updates and new drops'**
  String get settings_push_hint;

  /// No description provided for @settings_email.
  ///
  /// In en, this message translates to:
  /// **'Email updates'**
  String get settings_email;

  /// No description provided for @settings_email_hint.
  ///
  /// In en, this message translates to:
  /// **'Offers and the weekly edit'**
  String get settings_email_hint;

  /// No description provided for @settings_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_about;

  /// No description provided for @settings_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settings_version;

  /// No description provided for @help_title.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get help_title;

  /// No description provided for @help_faq.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked'**
  String get help_faq;

  /// No description provided for @help_q_shipping.
  ///
  /// In en, this message translates to:
  /// **'How long does delivery take?'**
  String get help_q_shipping;

  /// No description provided for @help_a_shipping.
  ///
  /// In en, this message translates to:
  /// **'Standard delivery takes 3–5 business days and express 1–2. Orders over \$75 ship free.'**
  String get help_a_shipping;

  /// No description provided for @help_q_returns.
  ///
  /// In en, this message translates to:
  /// **'Can I return an item?'**
  String get help_q_returns;

  /// No description provided for @help_a_returns.
  ///
  /// In en, this message translates to:
  /// **'Yes, within 30 days of delivery, unworn and with tags on. Refunds go back to the original payment method.'**
  String get help_a_returns;

  /// No description provided for @help_q_track.
  ///
  /// In en, this message translates to:
  /// **'Where is my order?'**
  String get help_q_track;

  /// No description provided for @help_a_track.
  ///
  /// In en, this message translates to:
  /// **'Open Profile → My orders and tap the order to see every step of its journey.'**
  String get help_a_track;

  /// No description provided for @help_q_cancel.
  ///
  /// In en, this message translates to:
  /// **'Can I cancel an order?'**
  String get help_q_cancel;

  /// No description provided for @help_a_cancel.
  ///
  /// In en, this message translates to:
  /// **'Orders can be cancelled until they ship. Open the order and tap Cancel order.'**
  String get help_a_cancel;

  /// No description provided for @help_q_promo.
  ///
  /// In en, this message translates to:
  /// **'How do promo codes work?'**
  String get help_q_promo;

  /// No description provided for @help_a_promo.
  ///
  /// In en, this message translates to:
  /// **'Enter the code in your bag. One code per order; some need a minimum subtotal.'**
  String get help_a_promo;

  /// No description provided for @help_q_points.
  ///
  /// In en, this message translates to:
  /// **'What are Tuku Points?'**
  String get help_q_points;

  /// No description provided for @help_a_points.
  ///
  /// In en, this message translates to:
  /// **'You earn 1 point for every dollar you spend. Points show on your profile.'**
  String get help_a_points;

  /// No description provided for @help_contact.
  ///
  /// In en, this message translates to:
  /// **'Still need help?'**
  String get help_contact;

  /// No description provided for @help_chat.
  ///
  /// In en, this message translates to:
  /// **'Chat with us'**
  String get help_chat;

  /// No description provided for @help_chat_hint.
  ///
  /// In en, this message translates to:
  /// **'Replies in a few minutes'**
  String get help_chat_hint;

  /// No description provided for @help_email.
  ///
  /// In en, this message translates to:
  /// **'Email us'**
  String get help_email;

  /// No description provided for @help_email_hint.
  ///
  /// In en, this message translates to:
  /// **'Replies within a day'**
  String get help_email_hint;

  /// No description provided for @help_call.
  ///
  /// In en, this message translates to:
  /// **'Call us'**
  String get help_call;

  /// No description provided for @help_call_hint.
  ///
  /// In en, this message translates to:
  /// **'9am–6pm, Monday to Saturday'**
  String get help_call_hint;

  /// No description provided for @help_contact_demo.
  ///
  /// In en, this message translates to:
  /// **'Contact is off in this demo.'**
  String get help_contact_demo;
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
