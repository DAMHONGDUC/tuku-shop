import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_local_data_source_impl.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:tuku_shop/src/features/auth/data/mock/auth_mock.dart';
import 'package:tuku_shop/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

void main() {
  late AuthRepositoryImpl repository;

  setUpAll(() => MockLatency.enabled = false);

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    repository = AuthRepositoryImpl(
      remote: AuthRemoteDataSourceImpl(),
      local: AuthLocalDataSourceImpl(await SharedPreferences.getInstance()),
    );
  });

  group('login', () {
    test('the demo account signs in and the session is stored', () async {
      final Either<Failure, UserEntity> result = await repository.login(
        email: AuthMock.demoEmail,
        password: AuthMock.demoPassword,
      );

      expect(result.isRight(), isTrue);
      final Either<Failure, UserEntity?> restored = await repository
          .restoreSession();
      expect(restored.getOrElse(() => null)?.email, AuthMock.demoEmail);
    });

    test('email is matched case-insensitively', () async {
      final Either<Failure, UserEntity> result = await repository.login(
        email: AuthMock.demoEmail.toUpperCase(),
        password: AuthMock.demoPassword,
      );

      expect(result.isRight(), isTrue);
    });

    test('a wrong password fails with invalidCredentials', () async {
      final Either<Failure, UserEntity> result = await repository.login(
        email: AuthMock.demoEmail,
        password: 'wrong',
      );

      expect(
        result,
        const Left<Failure, UserEntity>(
          ValidationFailure(FailureCodes.invalidCredentials),
        ),
      );
    });

    test('an unknown email fails with invalidCredentials', () async {
      final Either<Failure, UserEntity> result = await repository.login(
        email: 'nobody@example.com',
        password: AuthMock.demoPassword,
      );

      expect(
        result,
        const Left<Failure, UserEntity>(
          ValidationFailure(FailureCodes.invalidCredentials),
        ),
      );
    });
  });

  group('register', () {
    test('a new email creates an account that can then sign in', () async {
      final Either<Failure, UserEntity> registered = await repository.register(
        fullName: 'Sam Lee',
        email: 'sam@example.com',
        password: 'Secret123!',
      );
      expect(registered.isRight(), isTrue);

      final Either<Failure, UserEntity> login = await repository.login(
        email: 'sam@example.com',
        password: 'Secret123!',
      );
      expect(login.isRight(), isTrue);
    });

    test('an email already in use fails with emailTaken', () async {
      final Either<Failure, UserEntity> result = await repository.register(
        fullName: 'Someone',
        email: AuthMock.demoEmail,
        password: 'Secret123!',
      );

      expect(
        result,
        const Left<Failure, UserEntity>(
          ValidationFailure(FailureCodes.emailTaken),
        ),
      );
    });
  });

  test('logout clears the stored session and emits null', () async {
    await repository.login(
      email: AuthMock.demoEmail,
      password: AuthMock.demoPassword,
    );

    final Future<UserEntity?> next = repository.watchUser().skip(1).first;
    await repository.logout();

    expect(await next, isNull);
    expect(
      (await repository.restoreSession()).fold(
        (Failure f) => f,
        (UserEntity? u) => u,
      ),
      isNull,
    );
  });

  test('updateProfile changes the signed-in user', () async {
    await repository.login(
      email: AuthMock.demoEmail,
      password: AuthMock.demoPassword,
    );

    final Either<Failure, UserEntity> result = await repository.updateProfile(
      fullName: 'Alex M.',
      email: AuthMock.demoEmail,
      phone: '+1 000 000 0000',
    );

    expect(
      result.getOrElse(() => throw StateError('$result')).fullName,
      'Alex M.',
    );
  });
}
