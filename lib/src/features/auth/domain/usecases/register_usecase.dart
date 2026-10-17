import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  @override
  List<Object> get props => <Object>[fullName, email, password];
}

class RegisterUsecase implements UseCase<UserEntity, RegisterParams> {
  RegisterUsecase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) =>
      repository.register(
        fullName: params.fullName.trim(),
        email: params.email.trim(),
        password: params.password,
      );
}
