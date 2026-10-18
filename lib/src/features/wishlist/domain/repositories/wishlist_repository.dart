import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

abstract class WishlistRepository {
  /// Saved product ids, newest first; emits after every change.
  Stream<List<String>> watchIds();

  Future<Either<Failure, List<String>>> getIds();

  /// Adds or removes [productId]; returns whether it is now saved.
  Future<Either<Failure, bool>> toggle(String productId);

  Future<Either<Failure, Unit>> reset();
}
