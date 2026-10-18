import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

class UpdateProfileUsecase implements UseCase<UserEntity, UpdateProfileParams> {
  final AuthRepository repository;

  UpdateProfileUsecase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UpdateProfileParams params) {
    final name = params.fullName.trim();
    final phone = params.phone.trim();
    if (name.length < 2) {
      return Future.value(const Left(ValidationFailure('full_name')));
    }
    if (!RegExp(r'^\+?[0-9 ()-]{7,}$').hasMatch(phone)) {
      return Future.value(const Left(ValidationFailure('phone')));
    }
    return repository.updateProfile(fullName: name, phone: phone);
  }
}

class UpdateProfileParams extends Equatable {
  final String fullName;
  final String phone;

  const UpdateProfileParams({required this.fullName, required this.phone});

  @override
  List<Object?> get props => [fullName, phone];
}
