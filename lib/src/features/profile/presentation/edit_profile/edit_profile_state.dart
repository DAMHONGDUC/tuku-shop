part of 'edit_profile_controller.dart';

enum EditProfileFieldError { required, invalidEmail, invalidPhone }

class EditProfileState extends Equatable {
  const EditProfileState({
    this.submitting = false,
    this.saved = false,
    this.nameError,
    this.emailError,
    this.phoneError,
    this.failure,
  });

  final bool submitting;
  final bool saved;
  final EditProfileFieldError? nameError;
  final EditProfileFieldError? emailError;
  final EditProfileFieldError? phoneError;
  final Failure? failure;

  EditProfileState copyWith({
    bool? submitting,
    bool? saved,
    EditProfileFieldError? Function()? nameError,
    EditProfileFieldError? Function()? emailError,
    EditProfileFieldError? Function()? phoneError,
    Failure? Function()? failure,
  }) => EditProfileState(
    submitting: submitting ?? this.submitting,
    saved: saved ?? this.saved,
    nameError: nameError == null ? this.nameError : nameError(),
    emailError: emailError == null ? this.emailError : emailError(),
    phoneError: phoneError == null ? this.phoneError : phoneError(),
    failure: failure == null ? this.failure : failure(),
  );

  @override
  List<Object?> get props => <Object?>[
    submitting,
    saved,
    nameError,
    emailError,
    phoneError,
    failure,
  ];
}
