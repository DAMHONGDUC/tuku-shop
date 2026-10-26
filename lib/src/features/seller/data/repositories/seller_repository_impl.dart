import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/seller/data/data_sources/seller_remote_data_source.dart';
import 'package:tuku_shop/src/features/seller/data/mapper/seller_model_to_seller_mapper.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

class SellerRepositoryImpl implements SellerRepository {
  const SellerRepositoryImpl({required this.dataSource});

  final SellerRemoteDataSource dataSource;

  @override
  Future<Either<Failure, Seller>> getSeller(String id) async {
    try {
      return Right(
        SellerModelToSellerMapper.toEntity(await dataSource.getSeller(id)),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Seller>>> getSellersByIds(
    List<String> ids,
  ) async {
    try {
      final models = await dataSource.getSellersByIds(ids);
      return Right(models.map(SellerModelToSellerMapper.toEntity).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
