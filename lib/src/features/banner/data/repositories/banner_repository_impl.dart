import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/banner/data/data_sources/banner_remote_data_source.dart';
import 'package:tuku_shop/src/features/banner/data/mapper/banner_model_to_banner_entity_mapper.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';

class BannerRepositoryImpl implements BannerRepository {
  const BannerRepositoryImpl({required this.dataSource});

  final BannerRemoteDataSource dataSource;

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanners() async {
    try {
      final List<BannerEntity> banners = (await dataSource.getBanners())
          .map(BannerModelToBannerEntityMapper.toEntity)
          .toList();
      return Right<Failure, List<BannerEntity>>(banners);
    } catch (e, stackTrace) {
      SdLogger.error('BannerRepository', 'Load failed', error: e, stackTrace: stackTrace);
      return const Left<Failure, List<BannerEntity>>(ServerFailure());
    }
  }
}
