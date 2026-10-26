import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/seller/data/data_sources/seller_follow_local_data_source.dart';
import 'package:tuku_shop/src/features/seller/data/data_sources/seller_remote_data_source.dart';
import 'package:tuku_shop/src/features/seller/data/mapper/seller_model_to_seller_mapper.dart';
import 'package:tuku_shop/src/features/seller/data/models/seller_model.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

class SellerRepositoryImpl implements SellerRepository {
  const SellerRepositoryImpl({required this.dataSource, required this.follows});

  final SellerRemoteDataSource dataSource;
  final SellerFollowLocalDataSource follows;

  /// The shop with the shopper's follow merged in.
  static Seller _withFollow(SellerModel model, Set<String> followed) {
    final seller = SellerModelToSellerMapper.toEntity(model);
    final isFollowed = followed.contains(seller.id);
    return Seller(
      id: seller.id,
      name: seller.name,
      colorHex: seller.colorHex,
      rating: seller.rating,
      followerCount: seller.followerCount + (isFollowed ? 1 : 0),
      responseRate: seller.responseRate,
      location: seller.location,
      isOfficial: seller.isOfficial,
      isFollowed: isFollowed,
    );
  }

  @override
  Future<Either<Failure, Seller>> getSeller(String id) async {
    try {
      final model = await dataSource.getSeller(id);
      return Right(_withFollow(model, await follows.getFollowedIds()));
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
      final followed = await follows.getFollowedIds();
      return Right([for (final m in models) _withFollow(m, followed)]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Seller>> toggleFollow(String id) async {
    try {
      final followed = await follows.getFollowedIds();
      final next = followed.contains(id)
          ? ({...followed}..remove(id))
          : {...followed, id};
      await follows.saveFollowedIds(next);
      final model = await dataSource.getSeller(id);
      return Right(_withFollow(model, next));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetFollows() async {
    try {
      await follows.reset();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
