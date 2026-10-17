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
