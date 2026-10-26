import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/banner/data/data_sources/banner_remote_data_source.dart';
import 'package:tuku_shop/src/features/banner/data/mapper/banner_model_to_banner_item_mapper.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';

class BannerRepositoryImpl implements BannerRepository {
  const BannerRepositoryImpl({required this.dataSource});

  final BannerRemoteDataSource dataSource;

  @override
  Future<Either<Failure, List<BannerItem>>> getBanners() async {
    try {
      final result = await dataSource.getBanners();

      return Right(
        // In the order the source sends them: the same carousel every launch.
        result.map(BannerModelToBannerItemMapper.toEntity).toList(),
      );
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
