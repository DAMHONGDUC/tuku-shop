import 'package:tuku_shop/src/core/core.dart';

import '../repositories/wishlist_repository.dart';

class WatchWishlistUsecase implements StreamUseCase<List<String>, NoParams> {
  WatchWishlistUsecase(this.repository);

  final WishlistRepository repository;

  @override
  Stream<List<String>> call(NoParams params) => repository.watch();
}
