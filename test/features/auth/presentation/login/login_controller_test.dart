import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/auth/presentation/login/login_controller.dart';

import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockLoginUsecase usecase;

  const tUser = UserEntity(
    id: 'u-1',
    fullName: 'Demo',
    email: DemoAccount.email,
    phone: '',
    avatarUrl: '',
  );
  const tParams = LoginParams(
    email: DemoAccount.email,
    password: DemoAccount.password,
  );

  setUpAll(() => registerFallbackValue(tParams));

  setUp(() => usecase = MockLoginUsecase());

  blocTest<LoginController, LoginState>(
    'emits [Loading, Success] on valid credentials',
    setUp: () {
      when(
        () => usecase.call(tParams),
      ).thenAnswer((_) async => const Right(tUser));
    },
    build: () => LoginController(usecase),
    act: (c) =>
        c.login(email: DemoAccount.email, password: DemoAccount.password),
    expect: () => const [LoginLoadingState(), LoginSuccessState(user: tUser)],
  );

  blocTest<LoginController, LoginState>(
    'emits [Loading, Failure(invalidCredentials)] on a ValidationFailure',
    setUp: () {
      when(
        () => usecase.call(any()),
      ).thenAnswer((_) async => const Left(ValidationFailure('x')));
    },
    build: () => LoginController(usecase),
    act: (c) => c.login(email: DemoAccount.email, password: 'wrong'),
    expect: () => const [
      LoginLoadingState(),
      LoginFailureState(reason: LoginFailureReason.invalidCredentials),
    ],
  );

  blocTest<LoginController, LoginState>(
    'emits [Loading, Failure(unknown)] on any other failure',
    setUp: () {
      when(
        () => usecase.call(any()),
      ).thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => LoginController(usecase),
    act: (c) =>
        c.login(email: DemoAccount.email, password: DemoAccount.password),
    expect: () => const [
      LoginLoadingState(),
      LoginFailureState(reason: LoginFailureReason.unknown),
    ],
  );

  blocTest<LoginController, LoginState>(
    'emits a validation error and skips the usecase on empty fields',
    build: () => LoginController(usecase),
    act: (c) => c.login(email: '  ', password: ''),
    expect: () => const [
      LoginValidationErrorState(
        emailError: LoginFieldError.emailEmpty,
        passwordError: LoginFieldError.passwordEmpty,
      ),
    ],
    verify: (_) => verifyNever(() => usecase.call(any())),
  );

  blocTest<LoginController, LoginState>(
    'emits an invalid-email error on a malformed email',
    build: () => LoginController(usecase),
    act: (c) => c.login(email: 'not-an-email', password: 'pw'),
    expect: () => const [
      LoginValidationErrorState(emailError: LoginFieldError.emailInvalid),
    ],
  );
}
