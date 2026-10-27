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
  String get splash_description => 'Mua sắm mọi thứ ngay tại nhà';

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

  @override
  String get common_undo => 'Hoàn tác';

  @override
  String cart_title_count(int count) {
    return 'Giỏ hàng ($count)';
  }

  @override
  String get cart_update_failed => 'Không cập nhật được giỏ hàng. Thử lại.';

  @override
  String get cart_free_shipping_unlocked =>
      'Bạn được miễn phí giao hàng tiêu chuẩn 🎉';

  @override
  String cart_free_shipping_nudge(String amount) {
    return 'Mua thêm $amount để được miễn phí ship';
  }

  @override
  String get cart_subtotal => 'Tạm tính';

  @override
  String get cart_savings => 'Tiết kiệm';

  @override
  String get cart_shipping => 'Phí giao hàng';

  @override
  String get cart_shipping_at_checkout => 'Tính khi thanh toán';

  @override
  String cart_removed(String name) {
    return 'Đã xoá $name';
  }

  @override
  String get cart_remove => 'Xoá';

  @override
  String get common_delete => 'Xoá';

  @override
  String get cart_total => 'Tổng cộng';

  @override
  String get cart_checkout => 'Thanh toán';

  @override
  String get pdp_added_to_cart => 'Đã thêm vào giỏ';

  @override
  String get pdp_view_cart => 'Xem giỏ';

  @override
  String get pdp_add_failed => 'Không thêm được vào giỏ. Thử lại.';

  @override
  String sheet_in_stock(int count) {
    return 'Còn $count sản phẩm';
  }

  @override
  String get sheet_quantity => 'Số lượng';

  @override
  String sheet_add_to_cart(String total) {
    return 'Thêm vào giỏ · $total';
  }

  @override
  String sheet_buy_now(String total) {
    return 'Mua ngay · $total';
  }

  @override
  String get checkout_title => 'Thanh toán';

  @override
  String get checkout_items_title => 'Sản phẩm';

  @override
  String checkout_items(int count) {
    return 'Sản phẩm ($count)';
  }

  @override
  String get checkout_ship_to => 'Giao đến';

  @override
  String get checkout_change => 'Thay đổi';

  @override
  String get checkout_no_address => 'Thêm địa chỉ để tiếp tục';

  @override
  String get checkout_shipping => 'Vận chuyển';

  @override
  String checkout_shipping_days(int min, int max) {
    return '$min–$max ngày';
  }

  @override
  String get checkout_free => 'Miễn phí';

  @override
  String get checkout_payment => 'Thanh toán';

  @override
  String get checkout_voucher => 'Mã giảm giá';

  @override
  String get checkout_voucher_hint => 'Nhập mã';

  @override
  String get checkout_voucher_invalid => 'Mã không hợp lệ';

  @override
  String get checkout_voucher_try => 'Thử TUKU10 giảm 10% hoặc FREESHIP';

  @override
  String checkout_voucher_percent(String code, int percent) {
    return '$code · giảm $percent%';
  }

  @override
  String checkout_voucher_free_shipping(String code) {
    return '$code · miễn phí giao tiêu chuẩn';
  }

  @override
  String get checkout_apply => 'Áp dụng';

  @override
  String get checkout_summary => 'Tóm tắt';

  @override
  String get checkout_discount => 'Giảm giá';

  @override
  String checkout_place_order(String total) {
    return 'Đặt hàng · $total';
  }

  @override
  String get checkout_place_failed => 'Không đặt được hàng. Thử lại.';

  @override
  String get success_title => 'Đặt hàng thành công!';

  @override
  String get success_message =>
      'Cảm ơn bạn đã mua sắm. Chúng tôi sẽ báo khi hàng được gửi đi.';

  @override
  String get success_order => 'Đơn hàng';

  @override
  String get success_arrives => 'Dự kiến giao';

  @override
  String get success_track => 'Theo dõi đơn';

  @override
  String get success_continue => 'Tiếp tục mua sắm';

  @override
  String get address_book_title => 'Sổ địa chỉ';

  @override
  String get address_pick_title => 'Chọn địa chỉ';

  @override
  String get address_add => 'Thêm địa chỉ';

  @override
  String get address_edit => 'Sửa địa chỉ';

  @override
  String get address_default => 'Mặc định';

  @override
  String get address_set_default => 'Đặt làm mặc định';

  @override
  String get address_delete => 'Xoá';

  @override
  String get address_empty_title => 'Chưa có địa chỉ';

  @override
  String get address_empty_message => 'Thêm nơi bạn muốn nhận hàng.';

  @override
  String get address_full_name => 'Họ và tên';

  @override
  String get address_phone => 'Số điện thoại';

  @override
  String get address_street => 'Số nhà, tên đường';

  @override
  String get address_city => 'Thành phố';

  @override
  String get address_state => 'Tỉnh / Bang';

  @override
  String get address_postal_code => 'Mã bưu chính';

  @override
  String get address_make_default => 'Dùng làm địa chỉ mặc định';

  @override
  String get address_save => 'Lưu địa chỉ';

  @override
  String get address_save_failed => 'Không lưu được địa chỉ. Thử lại.';

  @override
  String get address_field_invalid => 'Kiểm tra lại trường này';

  @override
  String get orders_title => 'Đơn hàng của tôi';

  @override
  String get orders_empty_title => 'Chưa có đơn hàng';

  @override
  String get orders_empty_message => 'Đơn ở trạng thái này sẽ hiện ở đây.';

  @override
  String get order_status_to_confirm => 'Chờ xác nhận';

  @override
  String get order_status_to_ship => 'Chờ lấy hàng';

  @override
  String get order_status_on_the_way => 'Đang giao';

  @override
  String get order_status_delivered => 'Đã giao';

  @override
  String get order_status_cancelled => 'Đã huỷ';

  @override
  String get order_status_returned => 'Đã trả hàng';

  @override
  String get order_headline_to_confirm => 'Chúng tôi đã nhận đơn của bạn';

  @override
  String get order_headline_to_ship => 'Đơn hàng đang được đóng gói';

  @override
  String get order_headline_on_the_way => 'Đơn hàng đang trên đường giao';

  @override
  String get order_headline_delivered => 'Đã giao. Chúc bạn vui!';

  @override
  String get order_headline_cancelled => 'Đơn hàng đã bị huỷ';

  @override
  String get order_headline_returned => 'Đơn hàng đã được trả lại';

  @override
  String order_eta(String date) {
    return 'Dự kiến giao $date';
  }

  @override
  String order_more_items(int count) {
    return '+$count sản phẩm khác';
  }

  @override
  String order_items_total(int count) {
    return '$count sản phẩm · tổng';
  }

  @override
  String get order_cancel => 'Huỷ đơn';

  @override
  String get order_cancel_title => 'Huỷ đơn hàng này?';

  @override
  String get order_cancel_message =>
      'Đơn chưa được xác nhận nên bạn sẽ không bị tính phí.';

  @override
  String get order_cancel_keep => 'Giữ đơn';

  @override
  String get order_cancel_confirm => 'Huỷ đơn';

  @override
  String get order_cancelled_toast => 'Đã huỷ đơn';

  @override
  String get order_buy_again => 'Mua lại';

  @override
  String get common_cancel => 'Huỷ';

  @override
  String get profile_edit => 'Sửa thông tin';

  @override
  String get profile_save => 'Lưu thay đổi';

  @override
  String get profile_theme => 'Giao diện';

  @override
  String get profile_theme_system => 'Theo hệ thống';

  @override
  String get profile_theme_light => 'Sáng';

  @override
  String get profile_theme_dark => 'Tối';

  @override
  String get profile_language => 'Ngôn ngữ';

  @override
  String get profile_reset => 'Đặt lại dữ liệu demo';

  @override
  String get profile_reset_title => 'Đặt lại dữ liệu demo?';

  @override
  String get profile_reset_message =>
      'Giỏ hàng, yêu thích, đơn hàng, địa chỉ, thông báo và chat hỗ trợ trở về như lần mở đầu tiên. Bạn vẫn đăng nhập.';

  @override
  String get profile_reset_confirm => 'Đặt lại';

  @override
  String get profile_reset_done => 'Đã khôi phục dữ liệu demo';

  @override
  String get profile_logout => 'Đăng xuất';

  @override
  String get profile_demo_note => 'Bản demo với dữ liệu mẫu';

  @override
  String get register_title => 'Tạo tài khoản';

  @override
  String get register_subtitle =>
      'Lưu món yêu thích, theo dõi đơn và thanh toán nhanh hơn.';

  @override
  String get register_password_hint => 'Tối thiểu 6 ký tự';

  @override
  String get register_password_short => 'Dùng ít nhất 6 ký tự';

  @override
  String get register_button => 'Tạo tài khoản';

  @override
  String get register_have_account => 'Đã có tài khoản?';

  @override
  String get register_email_taken =>
      'Email này đã có tài khoản. Hãy đăng nhập.';

  @override
  String get notifications_filter_all => 'Tất cả';

  @override
  String get notifications_filter_orders => 'Đơn hàng';

  @override
  String get notifications_filter_offers => 'Ưu đãi';

  @override
  String get notifications_filter_updates => 'Cập nhật';

  @override
  String get notifications_new => 'Mới';

  @override
  String get notifications_earlier => 'Trước đó';

  @override
  String get notifications_empty_title => 'Bạn đã xem hết';

  @override
  String get notifications_empty_message =>
      'Cập nhật đơn hàng và ưu đãi sẽ hiện ở đây.';

  @override
  String notifications_minutes_ago(int count) {
    return '$count phút trước';
  }

  @override
  String notifications_hours_ago(int count) {
    return '$count giờ trước';
  }

  @override
  String notifications_days_ago(int count) {
    return '$count ngày trước';
  }

  @override
  String get profile_logout_title => 'Đăng xuất?';

  @override
  String get profile_logout_message =>
      'Giỏ hàng, yêu thích và đơn hàng vẫn được lưu trên máy này.';

  @override
  String get nav_notifications => 'Thông báo';

  @override
  String product_sold_count(String count) {
    return 'Đã bán $count';
  }

  @override
  String get profile_stat_orders => 'Đơn hàng';

  @override
  String get profile_favorites_empty =>
      'Chạm vào trái tim trên sản phẩm để lưu lại tại đây.';

  @override
  String get profile_bag_empty => 'Giỏ hàng đang trống';

  @override
  String get profile_shopping => 'Mua sắm';

  @override
  String get profile_settings => 'Cài đặt';

  @override
  String pdp_view_all_reviews(int count) {
    return 'Xem tất cả $count đánh giá';
  }

  @override
  String get pdp_no_reviews =>
      'Chưa có đánh giá. Hãy là người đầu tiên chia sẻ.';

  @override
  String get filter_title => 'Bộ lọc';

  @override
  String get filter_category => 'Danh mục';

  @override
  String get filter_price => 'Giá';

  @override
  String get filter_rating => 'Đánh giá';

  @override
  String filter_rating_up(String stars) {
    return 'Từ $stars★';
  }

  @override
  String get filter_size => 'Kích cỡ';

  @override
  String get filter_color => 'Màu sắc';

  @override
  String get filter_more => 'Khác';

  @override
  String get filter_in_stock => 'Còn hàng';

  @override
  String get filter_new => 'Hàng mới';

  @override
  String get filter_best_sellers => 'Bán chạy';

  @override
  String get filter_all => 'Tất cả';

  @override
  String get filter_reset => 'Đặt lại';

  @override
  String get filter_apply => 'Xem kết quả';

  @override
  String get filter_sort => 'Sắp xếp';

  @override
  String get filter_any => 'Bất kỳ';

  @override
  String get support_title => 'Chăm sóc khách hàng';

  @override
  String get support_subtitle => 'Thường trả lời trong vài phút';

  @override
  String get support_input_hint => 'Nhập tin nhắn…';

  @override
  String get support_send => 'Gửi';

  @override
  String get support_typing => 'Đang soạn tin…';

  @override
  String get support_send_failed => 'Chưa gửi được tin nhắn. Vui lòng thử lại.';

  @override
  String get support_quick_order => 'Đơn hàng của tôi đâu?';

  @override
  String get support_quick_return => 'Đổi hoặc trả hàng';

  @override
  String get support_quick_size => 'Tư vấn kích cỡ';

  @override
  String get support_quick_voucher => 'Có mã giảm giá không?';

  @override
  String get support_entry => 'Chat với chúng tôi';

  @override
  String get nav_chat => 'Chat';

  @override
  String get chat_title => 'Chat';

  @override
  String get chat_support_name => 'Tuku Care';

  @override
  String get chat_support_tag => 'Hỗ trợ';

  @override
  String get chat_official => 'Chính hãng';

  @override
  String chat_seller_stats(String rating, int rate, String followers) {
    return '★ $rating · Phản hồi $rate% · $followers người theo dõi';
  }

  @override
  String get chat_quick_stock => 'Sản phẩm này còn hàng không?';

  @override
  String get chat_quick_size => 'Tôi nên chọn size nào?';

  @override
  String get chat_quick_ship => 'Khi nào giao hàng?';

  @override
  String get chat_quick_discount => 'Có giảm giá không?';

  @override
  String get chat_empty_title => 'Chưa có cuộc trò chuyện';

  @override
  String get chat_empty_message =>
      'Nhắn tin cho shop từ trang sản phẩm, hoặc hỏi Tuku Care để được hỗ trợ.';

  @override
  String get chat_yesterday => 'Hôm qua';

  @override
  String get pdp_chat => 'Chat';

  @override
  String get pdp_view_shop => 'Xem shop';

  @override
  String get pdp_sold_by => 'Bán bởi';

  @override
  String get pdp_response_rate => 'Phản hồi';

  @override
  String get pdp_followers => 'Người theo dõi';

  @override
  String get shop_tab_shop => 'Shop';

  @override
  String get shop_tab_products => 'Sản phẩm';

  @override
  String get shop_tab_categories => 'Danh mục';

  @override
  String get shop_follow => 'Theo dõi';

  @override
  String get shop_following => 'Đang theo dõi';

  @override
  String get shop_top_picks => 'Nổi bật';

  @override
  String get shop_stat_products => 'Sản phẩm';

  @override
  String get shop_follow_failed => 'Chưa cập nhật được. Vui lòng thử lại.';

  @override
  String get pdp_model => 'Mẫu máy';

  @override
  String get pdp_select_model => 'Hãy chọn mẫu máy trước';

  @override
  String review_variation(String variant) {
    return 'Phân loại: $variant';
  }

  @override
  String get review_filter_all => 'Tất cả';

  @override
  String get review_no_match => 'Chưa có đánh giá cho phân loại này.';
}
