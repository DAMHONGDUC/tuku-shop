import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/auth/presentation/login/login_controller.dart';
import 'package:tuku_shop/src/features/auth/presentation/register/register_controller.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockRegisterUsecase register;

  const RegisterParams params = RegisterParams(
    fullName: 'Sam Lee',
    email: 'sam@example.com',
    password: 'Secret123!',
  );

  setUpAll(() => registerFallbackValue(params));

  setUp(() => register = MockRegisterUsecase());

  Future<void> submitValid(RegisterController c) => c.submit(
    fullName: params.fullName,
    email: params.email,
    password: params.password,
    confirm: params.password,
  );

  test('passwordStrength counts length, digit, capital and symbol', () {
    expect(RegisterController.passwordStrength('abc'), 0);
    expect(RegisterController.passwordStrength('abcdefgh'), 1);
    expect(RegisterController.passwordStrength('Abcdefg1!'), 4);
  });

  blocTest<RegisterController, RegisterState>(
    'every invalid field is flagged',
    build: () => RegisterController(register: register),
    act: (RegisterController c) => c.submit(
      fullName: ' ',
      email: 'x',
      password: 'short',
      confirm: 'other',
    ),
    expect: () => <RegisterState>[
      const RegisterState(
        nameError: LoginFieldError.required,
        emailError: LoginFieldError.invalidEmail,
        passwordError: LoginFieldError.tooShort,
        confirmError: LoginFieldError.mismatch,
      ),
    ],
    verify: (_) => verifyNever(() => register(any())),
  );

  blocTest<RegisterController, RegisterState>(
    'valid fields without accepting the terms send nothing',
    build: () => RegisterController(register: register),
    act: submitValid,
    expect: () => <RegisterState>[const RegisterState()],
    verify: (_) => verifyNever(() => register(any())),
  );

  blocTest<RegisterController, RegisterState>(
    'accepted terms and valid fields register',
    build: () {
      when(
        () => register(any()),
      ).thenAnswer((_) async => Right<Failure, UserEntity>(Fixtures.user));
      return RegisterController(register: register);
    },
    seed: () => const RegisterState(termsAccepted: true),
    act: submitValid,
    expect: () => <RegisterState>[
      const RegisterState(termsAccepted: true, submitting: true),
      const RegisterState(termsAccepted: true, done: true),
    ],
  );

  blocTest<RegisterController, RegisterState>(
    'a taken email surfaces the failure',
    build: () {
      when(() => register(any())).thenAnswer(
        (_) async => const Left<Failure, UserEntity>(
          ValidationFailure(FailureCodes.emailTaken),
        ),
      );
      return RegisterController(register: register);
    },
    seed: () => const RegisterState(termsAccepted: true),
    act: submitValid,
    expect: () => <RegisterState>[
      const RegisterState(termsAccepted: true, submitting: true),
      const RegisterState(
        termsAccepted: true,
        failure: ValidationFailure(FailureCodes.emailTaken),
      ),
    ],
  );
}
