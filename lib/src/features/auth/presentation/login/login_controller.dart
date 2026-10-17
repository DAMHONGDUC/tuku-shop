import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController({
    required this._login,
    required this._getDemoAccount,
    required this._requestPasswordReset,
  }) : super(const LoginState());

  final LoginUsecase _login;
  final GetDemoAccountUsecase _getDemoAccount;
  final RequestPasswordResetUsecase _requestPasswordReset;

  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static bool isValidEmail(String value) => _email.hasMatch(value.trim());

  /// Pre-fills the form with the test account.
  Future<void> loadDemoAccount() async {
    final Either<Failure, DemoAccount> result = await _getDemoAccount(
      const NoParams(),
    );
    result.fold(
      (Failure _) {},
      (DemoAccount demo) => emit(state.copyWith(demo: () => demo)),
    );
  }

  Future<void> submit({required String email, required String password}) async {
    final bool emailOk = isValidEmail(email);
    final bool passwordOk = password.isNotEmpty;

    emit(
      state.copyWith(
        emailError: () => emailOk ? null : LoginFieldError.invalidEmail,
        passwordError: () => passwordOk ? null : LoginFieldError.required,
        failure: () => null,
      ),
    );

    if (!emailOk || !passwordOk) return;

    emit(state.copyWith(status: LoginStatus.submitting));

    final Either<Failure, UserEntity> result = await _login(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (Failure failure) => emit(
        state.copyWith(status: LoginStatus.idle, failure: () => failure),
      ),
      (UserEntity _) => emit(state.copyWith(status: LoginStatus.success)),
    );
  }

  Future<bool> requestPasswordReset(String email) async {
    if (!isValidEmail(email)) return false;

    final Either<Failure, Unit> result = await _requestPasswordReset(email);
    return result.isRight();
  }
}
