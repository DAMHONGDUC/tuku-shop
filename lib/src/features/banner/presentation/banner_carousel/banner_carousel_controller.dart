import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';

part 'banner_carousel_state.dart';

class BannerCarouselController extends Cubit<BannerCarouselState> {
  BannerCarouselController(this._getBanners)
    : super(const BannerCarouselState());

  final GetBannersUsecase _getBanners;

  Future<void> load() async {
    emit(const BannerCarouselState());

    final Either<Failure, List<BannerEntity>> result = await _getBanners(
      const NoParams(),
    );

    result.fold(
      (Failure _) => emit(const BannerCarouselState(status: LoadStatus.failure)),
      (List<BannerEntity> banners) => emit(
        BannerCarouselState(status: LoadStatus.success, banners: banners),
      ),
    );
  }
}
