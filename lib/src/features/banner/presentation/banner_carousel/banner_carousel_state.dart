part of 'banner_carousel_controller.dart';

class BannerCarouselState extends Equatable {
  const BannerCarouselState({
    this.status = LoadStatus.loading,
    this.banners = const <BannerEntity>[],
  });

  final LoadStatus status;
  final List<BannerEntity> banners;

  @override
  List<Object> get props => <Object>[status, banners];
}
