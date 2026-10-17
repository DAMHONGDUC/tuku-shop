import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/demo_account.dart';
import '../repositories/auth_repository.dart';

class GetDemoAccountUsecase implements UseCase<DemoAccount, NoParams> {
  GetDemoAccountUsecase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, DemoAccount>> call(NoParams params) =>
      repository.getDemoAccount();
}
