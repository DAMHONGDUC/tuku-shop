import 'package:tuku_shop/src/core/core.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class WatchUserUsecase implements StreamUseCase<UserEntity?, NoParams> {
  WatchUserUsecase(this.repository);

  final AuthRepository repository;

  @override
  Stream<UserEntity?> call(NoParams params) => repository.watchUser();
}
