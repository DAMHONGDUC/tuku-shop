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
  String get error_title => 'Đã có lỗi xảy ra';

  @override
  String get error_message =>
      'Không thể tải dữ liệu lúc này. Hãy kiểm tra kết nối và thử lại.';

  @override
  String get action_retry => 'Thử lại';

  @override
  String get tab_home => 'Trang chủ';

  @override
  String get tab_shop => 'Cửa hàng';

  @override
  String get tab_wishlist => 'Yêu thích';

  @override
  String get tab_bag => 'Giỏ hàng';

  @override
  String get tab_profile => 'Tài khoản';

  @override
  String get splash_tagline => 'Mặc điều khiến bạn rung động';

  @override
  String get action_skip => 'Bỏ qua';

  @override
  String get action_next => 'Tiếp';

  @override
  String get onboarding_title_1 => 'Mặc theo\ncách bạn chuyển động';

  @override
  String get onboarding_body_1 =>
      'Trang phục vận động và đồ mặc hằng ngày, chọn lọc để thoải mái từ phòng tập đến phố phường.';

  @override
  String get onboarding_title_2 => 'Khám phá\nphong cách riêng';

  @override
  String get onboarding_body_2 =>
      'Xem hàng mới về, bộ sưu tập chọn lọc và ưu đãi dành riêng cho thành viên — tất cả ở một nơi.';

  @override
  String get onboarding_title_3 => 'Giao nhanh,\nđổi trả dễ dàng';

  @override
  String get onboarding_body_3 =>
      'Miễn phí giao hàng cho đơn từ \$75, theo dõi đơn trực tiếp và đổi trả trong 30 ngày.';

  @override
  String get onboarding_start => 'Bắt đầu';

  @override
  String get action_close => 'Đóng';

  @override
  String get login_title => 'Chào mừng trở lại';

  @override
  String get login_subtitle => 'Đăng nhập để tiếp tục mua sắm.';

  @override
  String get login_demo_title => 'Tài khoản dùng thử';

  @override
  String get login_demo_fill => 'Điền';

  @override
  String get field_email => 'Email';

  @override
  String get field_email_hint => 'ban@example.com';

  @override
  String get field_password => 'Mật khẩu';

  @override
  String get password_show => 'Hiện mật khẩu';

  @override
  String get password_hide => 'Ẩn mật khẩu';

  @override
  String get login_remember => 'Ghi nhớ đăng nhập';

  @override
  String get login_forgot => 'Quên mật khẩu?';

  @override
  String get login_submit => 'Đăng nhập';

  @override
  String get login_or => 'hoặc tiếp tục với';

  @override
  String get login_social_demo =>
      'Đăng nhập mạng xã hội đã tắt trong bản demo — hãy dùng tài khoản dùng thử.';

  @override
  String get login_no_account => 'Chưa có tài khoản?';

  @override
  String get login_create_account => 'Tạo tài khoản';

  @override
  String get forgot_title => 'Đặt lại mật khẩu';

  @override
  String get forgot_body =>
      'Nhập email bạn đã đăng ký, chúng tôi sẽ gửi đường dẫn để đặt mật khẩu mới.';

  @override
  String get forgot_submit => 'Gửi đường dẫn';

  @override
  String forgot_sent(String email) {
    return 'Đã gửi đường dẫn đến $email';
  }

  @override
  String get validation_required => 'Vui lòng không để trống';

  @override
  String get validation_email => 'Email không hợp lệ';

  @override
  String get validation_password_short => 'Mật khẩu tối thiểu 8 ký tự';

  @override
  String get validation_password_mismatch => 'Mật khẩu không khớp';

  @override
  String get auth_error_credentials =>
      'Email hoặc mật khẩu không đúng. Hãy thử tài khoản dùng thử.';

  @override
  String get auth_error_email_taken => 'Email này đã được đăng ký.';
}
