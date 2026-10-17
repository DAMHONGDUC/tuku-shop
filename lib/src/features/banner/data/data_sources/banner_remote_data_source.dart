import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/banner/data/mock/banner_mock.dart';
import 'package:tuku_shop/src/features/banner/data/models/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  const BannerRemoteDataSourceImpl();

  @override
  Future<List<BannerModel>> getBanners() async {
    await MockLatency.normal();
    return BannerMock.banners;
  }
}
