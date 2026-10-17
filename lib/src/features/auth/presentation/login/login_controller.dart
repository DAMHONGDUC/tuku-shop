import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

part 'login_state.dart';

final _kEmailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class LoginController extends Cubit<LoginState> {
  LoginController(this._loginUsecase) : super(const LoginInitialState());

  final LoginUsecase _loginUsecase;

  Future<void> login({required String email, required String password}) async {
    if (state is LoginLoadingState) return;

    final emailError = _validateEmail(email.trim());
    final passwordError = password.isEmpty
        ? LoginFieldError.passwordEmpty
        : null;
    if (emailError != null || passwordError != null) {
      emit(
        LoginValidationErrorState(
          emailError: emailError,
          passwordError: passwordError,
        ),
      );
      return;
    }

    emit(const LoginLoadingState());

    final result = await _loginUsecase.call(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) => emit(
        LoginFailureState(
          reason: failure is ValidationFailure
              ? LoginFailureReason.invalidCredentials
              : LoginFailureReason.unknown,
        ),
      ),
      (user) => emit(LoginSuccessState(user: user)),
    );
  }

  LoginFieldError? _validateEmail(String email) {
    if (email.isEmpty) return LoginFieldError.emailEmpty;
    if (!_kEmailPattern.hasMatch(email)) return LoginFieldError.emailInvalid;
    return null;
  }
}
