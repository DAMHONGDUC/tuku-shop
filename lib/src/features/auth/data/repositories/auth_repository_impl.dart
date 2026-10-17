import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/mapper/user_model_to_user_entity_mapper.dart';
import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.remote, required this.local});

  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  static const String _tag = 'AuthRepository';

  final StreamController<UserEntity?> _user =
      StreamController<UserEntity?>.broadcast();
  UserModel? _current;

  void _emit(UserModel? model) {
    _current = model;
    _user.add(
      model == null ? null : UserModelToUserEntityMapper.toEntity(model),
    );
  }

  @override
  Stream<UserEntity?> watchUser() async* {
    yield _current == null
        ? null
        : UserModelToUserEntityMapper.toEntity(_current!);
    yield* _user.stream;
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserModel user = await remote.login(
        email: email,
        password: password,
      );
      await local.saveSession(user);
      _emit(user);
      SdLogger.action(_tag, 'Signed in');

      return Right<Failure, UserEntity>(
        UserModelToUserEntityMapper.toEntity(user),
      );
    } on ValidationException catch (e) {
      return Left<Failure, UserEntity>(ValidationFailure(e.code));
    } catch (e, stackTrace) {
      SdLogger.error(_tag, 'Sign in failed', error: e, stackTrace: stackTrace);
      return const Left<Failure, UserEntity>(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final UserModel user = await remote.register(
        fullName: fullName,
        email: email,
        password: password,
      );
      await local.saveSession(user);
      _emit(user);
      SdLogger.action(_tag, 'Registered');

      return Right<Failure, UserEntity>(
        UserModelToUserEntityMapper.toEntity(user),
      );
    } on ValidationException catch (e) {
      return Left<Failure, UserEntity>(ValidationFailure(e.code));
    } catch (e, stackTrace) {
      SdLogger.error(_tag, 'Register failed', error: e, stackTrace: stackTrace);
      return const Left<Failure, UserEntity>(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await MockLatency.short();
      await local.clearSession();
      _emit(null);
      SdLogger.action(_tag, 'Signed out');

      return const Right<Failure, Unit>(unit);
    } catch (e, stackTrace) {
      SdLogger.error(_tag, 'Sign out failed', error: e, stackTrace: stackTrace);
      return const Left<Failure, Unit>(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> restoreSession() async {
    try {
      final UserModel? user = await local.readSession();
      _emit(user);

      return Right<Failure, UserEntity?>(
        user == null ? null : UserModelToUserEntityMapper.toEntity(user),
      );
    } catch (e, stackTrace) {
      SdLogger.error(
        _tag,
        'Restore session failed',
        error: e,
        stackTrace: stackTrace,
      );
      return const Left<Failure, UserEntity?>(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    required String fullName,
    required String email,
    required String phone,
  }) async {
    try {
      final UserModel user = await remote.updateProfile(
        userId: _current?.id ?? '',
        fullName: fullName,
        email: email,
        phone: phone,
      );
      await local.saveSession(user);
      _emit(user);

      return Right<Failure, UserEntity>(
        UserModelToUserEntityMapper.toEntity(user),
      );
    } catch (e, stackTrace) {
      SdLogger.error(
        _tag,
        'Update profile failed',
        error: e,
        stackTrace: stackTrace,
      );
      return const Left<Failure, UserEntity>(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> requestPasswordReset(String email) async {
    try {
      await remote.requestPasswordReset(email);
      return const Right<Failure, Unit>(unit);
    } catch (e, stackTrace) {
      SdLogger.error(
        _tag,
        'Password reset failed',
        error: e,
        stackTrace: stackTrace,
      );
      return const Left<Failure, Unit>(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, DemoAccount>> getDemoAccount() async {
    final ({String email, String password}) demo = remote.demoCredentials;

    return Right<Failure, DemoAccount>(
      DemoAccount(email: demo.email, password: demo.password),
    );
  }
}
