import 'package:tuku_shop/src/core/core.dart';

import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class WatchCartUsecase implements StreamUseCase<CartEntity, NoParams> {
  WatchCartUsecase(this.repository);

  final CartRepository repository;

  @override
  Stream<CartEntity> call(NoParams params) => repository.watch();
}
