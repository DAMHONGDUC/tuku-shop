/// Every bundled image path outside the product catalogue, which carries
/// its own in `product/data/mock/`.
abstract final class AppAssets {
  static const String _images = 'assets/images/';
  static const String _banner = '${_images}banner/';
  static const String _category = '${_images}category/';
  static const String _lookbook = '${_images}lookbook/';

  static const String userAvatar = '${_images}common/user_avatar.webp';

  static const String bannerNew = '${_banner}b_new.webp';
  static const String bannerWomen = '${_banner}b_women.webp';
  static const String bannerMen = '${_banner}b_men.webp';
  static const String bannerSale = '${_banner}b_sale.webp';
  static const String bannerYoga = '${_banner}b_yoga.webp';
  static const String bannerTraining = '${_banner}b_training.webp';

  static String category(String id) => '${_category}c_$id.webp';

  static const String lookMenPants = '${_lookbook}l_men_pants.webp';
  static const String lookWomenPants = '${_lookbook}l_women_pants.webp';
  static const String lookPerformance = '${_lookbook}l_performance.webp';
  static const String lookEco = '${_lookbook}l_eco.webp';
  static const String lookSaleMen = '${_lookbook}l_sale_men.webp';
  static const String lookGear = '${_lookbook}l_gear.webp';
  static const String lookErin = '${_lookbook}l_erin.webp';
  static const String lookHomePants = '${_lookbook}l_home_pants.webp';
  static const String lookHomePerformance = '${_lookbook}l_home_perf.webp';
}
