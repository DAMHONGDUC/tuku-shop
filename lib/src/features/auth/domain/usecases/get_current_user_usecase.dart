import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

class GetCurrentUserUsecase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUsecase(this.repository);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
