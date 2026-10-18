part of 'login_controller.dart';

enum LoginFieldError { emailEmpty, emailInvalid, passwordEmpty }

enum LoginFailureReason { invalidCredentials, unknown }

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitialState extends LoginState {
  const LoginInitialState();
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

final class LoginValidationErrorState extends LoginState {
  final LoginFieldError? emailError;
  final LoginFieldError? passwordError;

  const LoginValidationErrorState({this.emailError, this.passwordError});

  @override
  List<Object?> get props => [emailError, passwordError];
}

final class LoginSuccessState extends LoginState {
  final UserEntity user;

  const LoginSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class LoginFailureState extends LoginState {
  final LoginFailureReason reason;

  const LoginFailureState({required this.reason});

  @override
  List<Object?> get props => [reason];
}
