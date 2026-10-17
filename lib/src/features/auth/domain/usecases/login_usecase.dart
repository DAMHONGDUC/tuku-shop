import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}

class LoginUsecase implements UseCase<UserEntity, LoginParams> {
  LoginUsecase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) =>
      repository.login(email: params.email.trim(), password: params.password);
}
