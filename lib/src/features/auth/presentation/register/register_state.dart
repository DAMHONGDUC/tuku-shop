part of 'register_controller.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.submitting = false,
    this.done = false,
    this.termsAccepted = false,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmError,
    this.failure,
  });

  final bool submitting;
  final bool done;
  final bool termsAccepted;
  final LoginFieldError? nameError;
  final LoginFieldError? emailError;
  final LoginFieldError? passwordError;
  final LoginFieldError? confirmError;
  final Failure? failure;

  RegisterState copyWith({
    bool? submitting,
    bool? done,
    bool? termsAccepted,
    LoginFieldError? Function()? nameError,
    LoginFieldError? Function()? emailError,
    LoginFieldError? Function()? passwordError,
    LoginFieldError? Function()? confirmError,
    Failure? Function()? failure,
  }) => RegisterState(
    submitting: submitting ?? this.submitting,
    done: done ?? this.done,
    termsAccepted: termsAccepted ?? this.termsAccepted,
    nameError: nameError == null ? this.nameError : nameError(),
    emailError: emailError == null ? this.emailError : emailError(),
    passwordError: passwordError == null ? this.passwordError : passwordError(),
    confirmError: confirmError == null ? this.confirmError : confirmError(),
    failure: failure == null ? this.failure : failure(),
  );

  @override
  List<Object?> get props => <Object?>[
    submitting,
    done,
    termsAccepted,
    nameError,
    emailError,
    passwordError,
    confirmError,
    failure,
  ];
}
