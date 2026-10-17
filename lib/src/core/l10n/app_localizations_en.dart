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
}
