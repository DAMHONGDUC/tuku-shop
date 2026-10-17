import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileParams extends Equatable {
  const UpdateProfileParams({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  final String fullName;
  final String email;
  final String phone;

  @override
  List<Object> get props => <Object>[fullName, email, phone];
}

class UpdateProfileUsecase implements UseCase<UserEntity, UpdateProfileParams> {
  UpdateProfileUsecase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(UpdateProfileParams params) =>
      repository.updateProfile(
        fullName: params.fullName.trim(),
        email: params.email.trim(),
        phone: params.phone.trim(),
      );
}
