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

  @override
  String get common_retry => 'Thử lại';

  @override
  String get common_load_failed =>
      'Không tải được. Kiểm tra kết nối rồi thử lại.';

  @override
  String get common_see_all => 'Xem tất cả';

  @override
  String common_items_count(int count) {
    return '$count sản phẩm';
  }

  @override
  String get common_start_shopping => 'Mua sắm ngay';

  @override
  String get nav_home => 'Trang chủ';

  @override
  String get nav_categories => 'Danh mục';

  @override
  String get nav_wishlist => 'Yêu thích';

  @override
  String get nav_cart => 'Giỏ hàng';

  @override
  String get nav_profile => 'Tài khoản';

  @override
  String get home_search_hint => 'Tìm váy, quần jean…';

  @override
  String get home_categories => 'Danh mục';

  @override
  String get home_flash_sale => 'Flash sale';

  @override
  String get home_new_arrivals => 'Hàng mới về';

  @override
  String get home_best_sellers => 'Bán chạy';

  @override
  String get home_just_for_you => 'Dành cho bạn';

  @override
  String get categories_title => 'Danh mục';

  @override
  String products_count(int count) {
    return '$count sản phẩm';
  }

  @override
  String get sort_recommended => 'Đề xuất';

  @override
  String get sort_newest => 'Mới nhất';

  @override
  String get sort_price_low => 'Giá: thấp đến cao';

  @override
  String get sort_price_high => 'Giá: cao đến thấp';

  @override
  String get sort_rating => 'Đánh giá cao';

  @override
  String get filter_on_sale => 'Đang giảm giá';

  @override
  String get products_empty_title => 'Chưa có sản phẩm';

  @override
  String get products_empty_message => 'Thử bộ lọc hoặc danh mục khác.';

  @override
  String get search_hint => 'Tìm sản phẩm';

  @override
  String get search_recent => 'Gần đây';

  @override
  String get search_clear => 'Xoá';

  @override
  String get search_trending => 'Xu hướng';

  @override
  String get search_recommended => 'Gợi ý cho bạn';

  @override
  String get search_no_results_title => 'Không có kết quả';

  @override
  String get search_no_results_message =>
      'Kiểm tra chính tả hoặc thử từ rộng hơn, như \"váy\" hay \"jeans\".';

  @override
  String get badge_new => 'Mới';

  @override
  String badge_discount(int percent) {
    return '-$percent%';
  }

  @override
  String get pdp_color => 'Màu';

  @override
  String get pdp_size => 'Kích cỡ';

  @override
  String pdp_only_left(int count) {
    return 'Chỉ còn $count';
  }

  @override
  String get pdp_sold_out => 'Hết hàng';

  @override
  String get pdp_select_size => 'Hãy chọn kích cỡ trước';

  @override
  String get pdp_free_shipping => 'Miễn phí ship';

  @override
  String get pdp_free_shipping_sub => 'đơn trên \$100';

  @override
  String get pdp_delivery => '2–4 ngày';

  @override
  String get pdp_delivery_sub => 'giao hàng';

  @override
  String get pdp_returns => '30 ngày';

  @override
  String get pdp_returns_sub => 'đổi trả miễn phí';

  @override
  String get pdp_details => 'Chi tiết';

  @override
  String get pdp_material => 'Chất liệu';

  @override
  String get pdp_fit => 'Form dáng';

  @override
  String get pdp_reviews => 'Đánh giá';

  @override
  String pdp_reviews_count(int count) {
    return '$count đánh giá';
  }

  @override
  String get pdp_show_more_reviews => 'Xem thêm đánh giá';

  @override
  String get pdp_related => 'Có thể bạn cũng thích';

  @override
  String get pdp_add_to_cart => 'Thêm vào giỏ';

  @override
  String get pdp_buy_now => 'Mua ngay';

  @override
  String pdp_sold(int count) {
    return 'Đã bán $count';
  }

  @override
  String get wishlist_title => 'Yêu thích';

  @override
  String wishlist_title_count(int count) {
    return 'Yêu thích ($count)';
  }

  @override
  String get wishlist_empty_title => 'Lưu món bạn thích';

  @override
  String get wishlist_empty_message =>
      'Chạm vào trái tim trên sản phẩm để lưu lại xem sau.';

  @override
  String get cart_title => 'Giỏ hàng';

  @override
  String get cart_empty_title => 'Giỏ hàng trống';

  @override
  String get cart_empty_message => 'Tìm món bạn thích và thêm vào đây.';

  @override
  String get notifications_title => 'Thông báo';
}
