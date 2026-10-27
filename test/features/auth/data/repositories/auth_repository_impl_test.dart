import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';
import 'package:tuku_shop/src/features/auth/data/repositories/auth_repository_impl.dart';

import '../../../../helpers/mock_repositories.dart';

void main() {
  late MockAuthRemoteDataSource remote;
  late MockAuthLocalDataSource local;
  late AuthRepositoryImpl repository;

  const tUser = UserModel(id: 'u-1', fullName: 'Demo', email: 'a@b.com');

  setUpAll(() => registerFallbackValue(const UserModel()));

  setUp(() {
    remote = MockAuthRemoteDataSource();
    local = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: remote,
      localDataSource: local,
    );
  });

  group('getCurrentUser', () {
    test('maps the saved user to an entity', () async {
      when(() => local.getSessionUser()).thenAnswer((_) async => tUser);

      final result = await repository.getCurrentUser();

      result.fold((_) => fail('expected Right'), (user) {
        expect(user?.id, 'u-1');
        expect(user?.phone, '');
      });
    });

    test('returns Right(null) when signed out', () async {
      when(() => local.getSessionUser()).thenAnswer((_) async => null);

      expect(await repository.getCurrentUser(), const Right(null));
    });

    test('returns a CacheFailure when the store throws', () async {
      when(() => local.getSessionUser()).thenThrow(const CacheException());

      expect(await repository.getCurrentUser(), Left(CacheFailure()));
    });
  });

  group('login', () {
    test('saves the session and returns the user', () async {
      when(
        () => remote.login(email: 'a@b.com', password: 'pw'),
      ).thenAnswer((_) async => tUser);
      when(() => local.saveSessionUser(any())).thenAnswer((_) async {});

      final result = await repository.login(email: 'a@b.com', password: 'pw');

      expect(result.isRight(), isTrue);
      verify(() => local.saveSessionUser(tUser)).called(1);
    });

    test('returns a ValidationFailure on wrong credentials', () async {
      when(
        () => remote.login(email: 'a@b.com', password: 'bad'),
      ).thenThrow(const InvalidCredentialsException());

      final result = await repository.login(email: 'a@b.com', password: 'bad');

      expect(result, const Left(ValidationFailure('invalid_credentials')));
      verifyNever(() => local.saveSessionUser(any()));
    });
  });

  group('logout', () {
    test('clears the session', () async {
      when(() => local.clearSession()).thenAnswer((_) async {});

      expect(await repository.logout(), const Right(unit));
      verify(() => local.clearSession()).called(1);
    });

    test('returns a CacheFailure when clearing throws', () async {
      when(() => local.clearSession()).thenThrow(const CacheException());

      expect(await repository.logout(), Left(CacheFailure()));
    });
  });
}
