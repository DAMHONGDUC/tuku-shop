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
}
