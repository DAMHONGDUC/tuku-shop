import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/demo_account.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  /// The user from the last session on this device, or null.
  Future<Either<Failure, UserEntity?>> restoreSession();

  Future<Either<Failure, UserEntity>> updateProfile({
    required String fullName,
    required String email,
    required String phone,
  });

  Future<Either<Failure, Unit>> requestPasswordReset(String email);

  Future<Either<Failure, DemoAccount>> getDemoAccount();

  /// The signed-in user, replayed to each new listener.
  Stream<UserEntity?> watchUser();
}
