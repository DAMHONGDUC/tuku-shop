import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/mapper/user_model_to_user_entity_mapper.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await localDataSource.getSessionUser();

      return Right(
        user == null ? null : UserModelToUserEntityMapper.toEntity(user),
      );
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      await localDataSource.saveSessionUser(user);

      return Right(UserModelToUserEntityMapper.toEntity(user));
    } on InvalidCredentialsException {
      return const Left(ValidationFailure('invalid_credentials'));
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await localDataSource.clearSession();

      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    required String fullName,
    required String phone,
  }) async {
    try {
      final user = await localDataSource.updateSessionUser(
        fullName: fullName,
        phone: phone,
      );
      return Right(UserModelToUserEntityMapper.toEntity(user));
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
