import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The saved product ids. The products themselves come from the catalogue,
/// so a price change shows up in the wishlist too.
abstract class WishlistRepository {
  /// The ids, newest first, replayed to each new listener.
  Stream<List<String>> watch();

  /// Saves or unsaves [productId]; returns whether it is now saved.
  Future<Either<Failure, bool>> toggle(String productId);
}
