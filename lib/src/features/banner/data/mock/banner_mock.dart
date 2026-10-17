import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/banner/data/models/banner_model.dart';

abstract final class BannerMock {
  static const List<BannerModel> banners = <BannerModel>[
    BannerModel(
      id: 'b_new',
      eyebrow: 'NEW SEASON',
      title: 'Autumn\nEssentials',
      subtitle: 'Layers built for crisp mornings',
      image: AppAssets.bannerNew,
      target: <String, String>{'title': 'New arrivals', 'new': '1', 'sort': 'newest'},
    ),
    BannerModel(
      id: 'b_sale',
      eyebrow: 'UP TO 40% OFF',
      title: 'The Mid-Season\nSale',
      subtitle: 'Last chance on runners\' favourites',
      image: AppAssets.bannerSale,
      target: <String, String>{'title': 'Sale', 'sale': '1'},
    ),
    BannerModel(
      id: 'b_women',
      eyebrow: 'WOMEN',
      title: 'Move\nBeautifully',
      subtitle: 'Bras, leggings and layers for every flow',
      image: AppAssets.bannerWomen,
      target: <String, String>{'title': 'Women', 'gender': 'women'},
    ),
    BannerModel(
      id: 'b_men',
      eyebrow: 'MEN',
      title: 'Coastline\nCollection',
      subtitle: 'Easy fits for long weekends',
      image: AppAssets.bannerMen,
      target: <String, String>{'title': 'Men', 'gender': 'men'},
    ),
    BannerModel(
      id: 'b_yoga',
      eyebrow: 'STUDIO EDIT',
      title: 'Find Your\nBalance',
      subtitle: 'Soft, breathable, made to stretch',
      image: AppAssets.bannerYoga,
      target: <String, String>{'title': 'Tanks & bras', 'category': 'tanks'},
    ),
  ];
}
