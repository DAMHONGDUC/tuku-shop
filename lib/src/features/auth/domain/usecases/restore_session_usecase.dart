import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RestoreSessionUsecase implements UseCase<UserEntity?, NoParams> {
  RestoreSessionUsecase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) =>
      repository.restoreSession();
}
