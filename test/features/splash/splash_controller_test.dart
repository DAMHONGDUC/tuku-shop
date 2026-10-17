import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/splash/splash_controller.dart';

import '../../helpers/mock_usecases.dart';

void main() {
  late MockGetCurrentUserUsecase usecase;

  const tUser = UserEntity(
    id: 'u-1',
    fullName: 'Demo',
    email: 'a@b.com',
    phone: '',
    avatarUrl: '',
  );

  setUp(() => usecase = MockGetCurrentUserUsecase());

  blocTest<SplashController, SplashState>(
    'emits [LoggedIn] when a session user exists',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => const Right(tUser));
    },
    build: () => SplashController(usecase),
    act: (c) => c.checkLoginStatus(),
    wait: const Duration(milliseconds: 1100),
    expect: () => [LoggedInLState()],
  );

  blocTest<SplashController, SplashState>(
    'emits [NotLoggedIn] when there is no session',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => const Right(null));
    },
    build: () => SplashController(usecase),
    act: (c) => c.checkLoginStatus(),
    wait: const Duration(milliseconds: 1100),
    expect: () => [NotLogInLState()],
  );

  blocTest<SplashController, SplashState>(
    'emits [NotLoggedIn] when reading the session fails',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => Left(CacheFailure()));
    },
    build: () => SplashController(usecase),
    act: (c) => c.checkLoginStatus(),
    wait: const Duration(milliseconds: 1100),
    expect: () => [NotLogInLState()],
  );
}
