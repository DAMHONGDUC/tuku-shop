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

  @override
  String get register_title => 'Tạo tài khoản';

  @override
  String get register_subtitle =>
      'Tham gia Tuku để nhận giá thành viên, thanh toán nhanh và theo dõi đơn hàng.';

  @override
  String get field_full_name => 'Họ và tên';

  @override
  String get field_full_name_hint => 'Nguyễn Văn A';

  @override
  String get field_confirm_password => 'Xác nhận mật khẩu';

  @override
  String get register_terms =>
      'Tôi đồng ý với Điều khoản dịch vụ và Chính sách bảo mật';

  @override
  String get register_accept_terms => 'Vui lòng đồng ý điều khoản để tiếp tục';

  @override
  String get register_submit => 'Tạo tài khoản';

  @override
  String get register_have_account => 'Đã có tài khoản?';

  @override
  String get register_welcome =>
      'Chào mừng đến với Tuku! Bạn được tặng 200 điểm.';

  @override
  String get password_weak => 'Yếu';

  @override
  String get password_fair => 'Trung bình';

  @override
  String get password_good => 'Khá';

  @override
  String get password_strong => 'Mạnh';

  @override
  String get action_shop_now => 'Mua ngay';

  @override
  String get action_see_all => 'Xem tất cả';

  @override
  String get home_categories => 'Danh mục';

  @override
  String get badge_new => 'MỚI';

  @override
  String get wishlist_add => 'Thêm vào yêu thích';

  @override
  String get wishlist_remove => 'Bỏ khỏi yêu thích';

  @override
  String get sort_recommended => 'Đề xuất';

  @override
  String get sort_newest => 'Mới nhất';

  @override
  String get sort_price_low => 'Giá: thấp đến cao';

  @override
  String get sort_price_high => 'Giá: cao đến thấp';

  @override
  String get sort_top_rated => 'Đánh giá cao';

  @override
  String get sort_best_selling => 'Bán chạy';

  @override
  String get gender_all => 'Tất cả';

  @override
  String get gender_men => 'Nam';

  @override
  String get gender_women => 'Nữ';

  @override
  String get gender_unisex => 'Unisex';

  @override
  String get home_flash_sale => 'Flash sale';

  @override
  String get home_flash_sale_subtitle => 'Giảm sâu nhất, chỉ trong vài giờ';

  @override
  String get home_flash_sale_all => 'Xem toàn bộ sản phẩm giảm giá';

  @override
  String home_flash_sale_ends(String time) {
    return 'Kết thúc sau $time';
  }

  @override
  String get home_recommended => 'Dành riêng cho bạn';

  @override
  String get home_recommended_subtitle => 'Dựa trên xu hướng tuần này';

  @override
  String get search_hint => 'Tìm hoodie, quần legging, túi…';

  @override
  String get home_greeting_morning => 'Chào buổi sáng';

  @override
  String get home_greeting_afternoon => 'Chào buổi chiều';

  @override
  String get home_greeting_evening => 'Chào buổi tối';

  @override
  String get home_guest => 'bạn';

  @override
  String get notifications_title => 'Thông báo';

  @override
  String get perk_shipping => 'Miễn phí ship\ntừ \$75';

  @override
  String get perk_returns => 'Đổi trả\n30 ngày';

  @override
  String get perk_secure => 'Thanh toán\nan toàn';

  @override
  String get home_new_arrivals => 'Hàng mới về';

  @override
  String get home_new_arrivals_subtitle => 'Vừa lên kệ tuần này';

  @override
  String get home_best_sellers => 'Bán chạy nhất';

  @override
  String get home_lookbook => 'Mua theo phong cách';

  @override
  String get home_lookbook_subtitle => 'Tuyển chọn từ studio của chúng tôi';

  @override
  String get home_look_women => 'Từ phòng tập ra phố';

  @override
  String get home_look_men => 'Dành cho những chuyến đi biển';

  @override
  String get home_look_performance => 'Bộ sưu tập vận động';

  @override
  String get home_look_performance_caption =>
      'Những món được đánh giá cao nhất';

  @override
  String get browse_empty_title => 'Không tìm thấy sản phẩm';

  @override
  String get browse_empty_message => 'Hãy thử danh mục khác hoặc bớt bộ lọc.';

  @override
  String browse_end(int count) {
    return 'Đã hiển thị toàn bộ $count sản phẩm';
  }

  @override
  String get browse_all_categories => 'Tất cả';

  @override
  String get browse_loading => 'Đang tải…';

  @override
  String browse_count(int count) {
    return '$count sản phẩm';
  }

  @override
  String get sort_title => 'Sắp xếp theo';

  @override
  String get filter_title => 'Bộ lọc';

  @override
  String get filter_reset => 'Đặt lại';

  @override
  String get filter_clear => 'Xóa bộ lọc';

  @override
  String get filter_apply => 'Xem kết quả';

  @override
  String get filter_price => 'Giá';

  @override
  String get filter_size => 'Kích cỡ';

  @override
  String get filter_color => 'Màu sắc';

  @override
  String get filter_on_sale => 'Chỉ hàng giảm giá';

  @override
  String get filter_new_only => 'Chỉ hàng mới về';

  @override
  String get shop_title => 'Cửa hàng';

  @override
  String get search_title => 'Tìm kiếm';

  @override
  String get search_clear => 'Xóa';

  @override
  String get search_recent => 'Tìm kiếm gần đây';

  @override
  String get search_clear_recent => 'Xóa';

  @override
  String get search_trending => 'Xu hướng';

  @override
  String get action_share => 'Chia sẻ';

  @override
  String get action_decrease => 'Giảm';

  @override
  String get action_increase => 'Tăng';

  @override
  String get detail_link_copied => 'Đã sao chép liên kết sản phẩm';

  @override
  String get detail_related => 'Có thể bạn cũng thích';

  @override
  String get badge_eco => 'Thân thiện';

  @override
  String get badge_best_seller => 'Bán chạy';

  @override
  String detail_rating(String rating) {
    return 'Đánh giá $rating/5';
  }

  @override
  String detail_reviews(int count) {
    return '$count đánh giá';
  }

  @override
  String detail_sold(String sold) {
    return 'Đã bán $sold';
  }

  @override
  String detail_save(String amount) {
    return 'Tiết kiệm $amount';
  }

  @override
  String get detail_color => 'Màu';

  @override
  String get detail_size => 'Size';

  @override
  String get detail_size_pick => 'Chọn size';

  @override
  String get detail_size_guide => 'Bảng size';

  @override
  String get detail_quantity => 'Số lượng';

  @override
  String get size_guide_tops =>
      'Số đo cơ thể tính bằng inch. Nếu ở giữa hai size, hãy chọn size lớn hơn để mặc thoải mái.';

  @override
  String get size_guide_bottoms => 'Số đo vòng eo tính bằng inch.';

  @override
  String get size_guide_note =>
      'Đổi size miễn phí trong 30 ngày nếu không vừa.';

  @override
  String get size_chest => 'Ngực';

  @override
  String get size_waist => 'Eo';

  @override
  String get size_hips => 'Hông';

  @override
  String get detail_perk_shipping => 'Miễn phí giao hàng từ \$75';

  @override
  String get detail_perk_shipping_sub => 'Nhận hàng trong 3–5 ngày làm việc';

  @override
  String get detail_perk_returns => 'Đổi trả miễn phí 30 ngày';

  @override
  String get detail_perk_returns_sub =>
      'Không vừa? Gửi trả, chúng tôi chịu phí';

  @override
  String get detail_description => 'Mô tả';

  @override
  String get detail_material => 'Chất liệu';

  @override
  String get detail_read_more => 'Xem thêm';

  @override
  String get detail_read_less => 'Thu gọn';

  @override
  String review_variant(String color, String size) {
    return 'Size $size · $color';
  }

  @override
  String review_helpful(int count) {
    return '$count người thấy hữu ích';
  }

  @override
  String get detail_reviews_title => 'Đánh giá';

  @override
  String detail_all_reviews(int count) {
    return 'Xem tất cả $count đánh giá';
  }

  @override
  String get detail_choose_size => 'Vui lòng chọn size trước';

  @override
  String get detail_added => 'Đã thêm vào giỏ hàng';

  @override
  String get detail_view_bag => 'Xem giỏ hàng';

  @override
  String get detail_add_to_bag => 'Thêm vào giỏ';

  @override
  String get reviews_empty => 'Chưa có đánh giá với số sao này';

  @override
  String get wishlist_title => 'Yêu thích';

  @override
  String wishlist_count(int count) {
    return '$count sản phẩm đã lưu';
  }

  @override
  String get wishlist_empty_title => 'Danh sách yêu thích trống';

  @override
  String get wishlist_empty_message =>
      'Nhấn vào trái tim ở sản phẩm bạn thích, chúng sẽ được lưu ở đây.';

  @override
  String get wishlist_move_to_bag => 'Thêm vào giỏ';

  @override
  String get action_start_shopping => 'Bắt đầu mua sắm';
}
