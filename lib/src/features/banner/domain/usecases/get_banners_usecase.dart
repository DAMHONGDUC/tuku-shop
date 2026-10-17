import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/banner_entity.dart';
import '../repositories/banner_repository.dart';

class GetBannersUsecase implements UseCase<List<BannerEntity>, NoParams> {
  GetBannersUsecase(this.repository);

  final BannerRepository repository;

  @override
  Future<Either<Failure, List<BannerEntity>>> call(NoParams params) =>
      repository.getBanners();
}
