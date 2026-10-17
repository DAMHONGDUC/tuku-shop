import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/auth/presentation/login/login_controller.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockLoginUsecase login;
  late MockGetDemoAccountUsecase getDemoAccount;
  late MockRequestPasswordResetUsecase requestPasswordReset;

  const LoginParams params = LoginParams(
    email: 'alex@example.com',
    password: 'secret',
  );

  setUpAll(() => registerFallbackValue(params));

  setUp(() {
    login = MockLoginUsecase();
    getDemoAccount = MockGetDemoAccountUsecase();
    requestPasswordReset = MockRequestPasswordResetUsecase();
  });

  LoginController build() => LoginController(
    login: login,
    getDemoAccount: getDemoAccount,
    requestPasswordReset: requestPasswordReset,
  );

  blocTest<LoginController, LoginState>(
    'invalid fields are flagged and nothing is sent',
    build: build,
    act: (LoginController c) => c.submit(email: 'not-an-email', password: ''),
    expect: () => <LoginState>[
      const LoginState(
        emailError: LoginFieldError.invalidEmail,
        passwordError: LoginFieldError.required,
      ),
    ],
    verify: (_) => verifyNever(() => login(any())),
  );

  blocTest<LoginController, LoginState>(
    'valid credentials go submitting → success',
    build: () {
      when(
        () => login(any()),
      ).thenAnswer((_) async => Right<Failure, UserEntity>(Fixtures.user));
      return build();
    },
    act: (LoginController c) =>
        c.submit(email: params.email, password: params.password),
    expect: () => <LoginState>[
      const LoginState(),
      const LoginState(status: LoginStatus.submitting),
      const LoginState(status: LoginStatus.success),
    ],
    verify: (_) => verify(() => login(params)).called(1),
  );

  blocTest<LoginController, LoginState>(
    'a rejected sign-in returns to idle with the failure',
    build: () {
      when(() => login(any())).thenAnswer(
        (_) async => const Left<Failure, UserEntity>(
          ValidationFailure(FailureCodes.invalidCredentials),
        ),
      );
      return build();
    },
    act: (LoginController c) =>
        c.submit(email: params.email, password: params.password),
    expect: () => <LoginState>[
      const LoginState(),
      const LoginState(status: LoginStatus.submitting),
      const LoginState(
        failure: ValidationFailure(FailureCodes.invalidCredentials),
      ),
    ],
  );

  blocTest<LoginController, LoginState>(
    'loadDemoAccount exposes the demo credentials',
    build: () {
      when(() => getDemoAccount(const NoParams())).thenAnswer(
        (_) async => const Right<Failure, DemoAccount>(
          DemoAccount(email: 'demo@tukushop.com', password: 'Tuku@2026'),
        ),
      );
      return build();
    },
    act: (LoginController c) => c.loadDemoAccount(),
    expect: () => <LoginState>[
      const LoginState(
        demo: DemoAccount(email: 'demo@tukushop.com', password: 'Tuku@2026'),
      ),
    ],
  );
}
