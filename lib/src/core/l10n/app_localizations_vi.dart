// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get app_name => 'Tuku Shop';

  @override
  String get splash_description => 'Any shopping just from home';

  @override
  String get login_title => 'Chào mừng trở lại';

  @override
  String get login_subtitle => 'Đăng nhập để tiếp tục mua sắm';

  @override
  String get login_email_label => 'Email';

  @override
  String get login_email_hint => 'ban@example.com';

  @override
  String get login_password_label => 'Mật khẩu';

  @override
  String get login_password_hint => 'Nhập mật khẩu';

  @override
  String get login_button => 'Đăng nhập';

  @override
  String get login_signing_in => 'Đang đăng nhập...';

  @override
  String get login_no_account => 'Chưa có tài khoản?';

  @override
  String get login_register => 'Đăng ký';

  @override
  String get login_demo_title => 'Tài khoản demo';

  @override
  String get login_demo_fill => 'Dùng tài khoản demo';

  @override
  String get login_error_email_empty => 'Vui lòng nhập email';

  @override
  String get login_error_email_invalid => 'Email không hợp lệ';

  @override
  String get login_error_password_empty => 'Vui lòng nhập mật khẩu';

  @override
  String get login_error_invalid_credentials =>
      'Email hoặc mật khẩu không đúng';

  @override
  String get login_error_unknown => 'Đã có lỗi xảy ra. Vui lòng thử lại';

  @override
  String get logout_failed => 'Không thể đăng xuất. Vui lòng thử lại';
}
