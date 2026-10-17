import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../repositories/auth_repository.dart';

class RequestPasswordResetUsecase implements UseCase<Unit, String> {
  RequestPasswordResetUsecase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(String email) =>
      repository.requestPasswordReset(email.trim());
}
