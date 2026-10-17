import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import '../login/login_controller.dart';

part 'register_state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController({required RegisterUsecase register})
    : _register = register,
      super(const RegisterState());

  final RegisterUsecase _register;

  static const int minPasswordLength = 8;

  /// 0–4: length, a digit, a capital, a symbol.
  static int passwordStrength(String value) =>
      <bool>[
        value.length >= minPasswordLength,
        value.contains(RegExp(r'\d')),
        value.contains(RegExp(r'[A-Z]')),
        value.contains(RegExp(r'[^A-Za-z0-9]')),
      ].where((bool b) => b).length;

  void acceptTerms(bool value) => emit(state.copyWith(termsAccepted: value));

  Future<void> submit({
    required String fullName,
    required String email,
    required String password,
    required String confirm,
  }) async {
    final LoginFieldError? nameError = fullName.trim().isEmpty
        ? LoginFieldError.required
        : null;
    final LoginFieldError? emailError = LoginController.isValidEmail(email)
        ? null
        : LoginFieldError.invalidEmail;
    final LoginFieldError? passwordError = password.length < minPasswordLength
        ? LoginFieldError.tooShort
        : null;
    final LoginFieldError? confirmError = confirm != password
        ? LoginFieldError.mismatch
        : null;

    emit(
      state.copyWith(
        nameError: () => nameError,
        emailError: () => emailError,
        passwordError: () => passwordError,
        confirmError: () => confirmError,
        failure: () => null,
      ),
    );

    if (<Object?>[nameError, emailError, passwordError, confirmError].any(
          (Object? e) => e != null,
        ) ||
        !state.termsAccepted) {
      return;
    }

    emit(state.copyWith(submitting: true));

    final Either<Failure, UserEntity> result = await _register(
      RegisterParams(fullName: fullName, email: email, password: password),
    );

    result.fold(
      (Failure f) => emit(state.copyWith(submitting: false, failure: () => f)),
      (UserEntity _) => emit(state.copyWith(submitting: false, done: true)),
    );
  }
}
