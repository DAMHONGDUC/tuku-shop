import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/seller/domain/entities/seller.dart';
import 'package:tuku_shop/src/features/seller/domain/repositories/seller_repository.dart';

class GetSellerUsecase implements UseCase<Seller, String> {
  final SellerRepository repository;

  GetSellerUsecase(this.repository);

  @override
  Future<Either<Failure, Seller>> call(String params) =>
      repository.getSeller(params);
}

class GetSellersByIdsUsecase implements UseCase<List<Seller>, List<String>> {
  final SellerRepository repository;

  GetSellersByIdsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Seller>>> call(List<String> params) {
    if (params.isEmpty) return Future.value(const Right([]));
    return repository.getSellersByIds(params);
  }
}

class ToggleFollowSellerUsecase implements UseCase<Seller, String> {
  final SellerRepository repository;

  ToggleFollowSellerUsecase(this.repository);

  @override
  Future<Either<Failure, Seller>> call(String params) =>
      repository.toggleFollow(params);
}

class ResetFollowedSellersUsecase implements UseCase<Unit, NoParams> {
  final SellerRepository repository;

  ResetFollowedSellersUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) =>
      repository.resetFollows();
}
