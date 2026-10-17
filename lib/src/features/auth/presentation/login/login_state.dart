part of 'login_controller.dart';

enum LoginStatus { idle, submitting, success }

enum LoginFieldError { required, invalidEmail, tooShort, mismatch }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.idle,
    this.demo,
    this.emailError,
    this.passwordError,
    this.failure,
  });

  final LoginStatus status;
  final DemoAccount? demo;
  final LoginFieldError? emailError;
  final LoginFieldError? passwordError;
  final Failure? failure;

  LoginState copyWith({
    LoginStatus? status,
    DemoAccount? Function()? demo,
    LoginFieldError? Function()? emailError,
    LoginFieldError? Function()? passwordError,
    Failure? Function()? failure,
  }) => LoginState(
    status: status ?? this.status,
    demo: demo == null ? this.demo : demo(),
    emailError: emailError == null ? this.emailError : emailError(),
    passwordError: passwordError == null ? this.passwordError : passwordError(),
    failure: failure == null ? this.failure : failure(),
  );

  @override
  List<Object?> get props => <Object?>[
    status,
    demo,
    emailError,
    passwordError,
    failure,
  ];
}
