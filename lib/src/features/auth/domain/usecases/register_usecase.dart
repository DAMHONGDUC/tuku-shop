import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

enum RegisterField { fullName, email, password }

class RegisterUsecase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static Set<RegisterField> validate(RegisterParams p) => {
    if (p.fullName.trim().length < 2) RegisterField.fullName,
    if (!_email.hasMatch(p.email.trim())) RegisterField.email,
    if (p.password.length < 6) RegisterField.password,
  };

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    final errors = validate(params);
    if (errors.isNotEmpty) {
      return Future.value(Left(ValidationFailure(errors.first.name)));
    }
    return repository.register(
      fullName: params.fullName.trim(),
      email: params.email.trim(),
      password: params.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String fullName;
  final String email;
  final String password;

  const RegisterParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, password];
}
