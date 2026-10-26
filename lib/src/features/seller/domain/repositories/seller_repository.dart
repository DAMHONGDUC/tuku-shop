import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/seller/domain/entities/seller.dart';

abstract class SellerRepository {
  Future<Either<Failure, Seller>> getSeller(String id);

  /// The sellers for [ids], in that order; unknown ids are skipped.
  Future<Either<Failure, List<Seller>>> getSellersByIds(List<String> ids);
}
