import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/auth_repository.dart';

class LogoutUsecase implements UseCase<Unit, NoParams> {
  LogoutUsecase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.logout();
}
