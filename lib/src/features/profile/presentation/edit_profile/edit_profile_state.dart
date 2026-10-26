part of 'edit_profile_controller.dart';

enum EditProfileStatus { loading, loaded, error }

class EditProfileState extends Equatable {
  /// Loading the signed-in user the form starts from.
  final EditProfileStatus status;
  final UserEntity? user;

  /// The field code that failed validation, if any.
  final String? invalidField;
  final bool isSaving;
  final UserEntity? saved;
  final bool saveFailed;

  const EditProfileState({
    this.status = EditProfileStatus.loading,
    this.user,
    this.invalidField,
    this.isSaving = false,
    this.saved,
    this.saveFailed = false,
  });

  /// A save attempt's outcome on top of the loaded user.
  EditProfileState withSave({
    String? invalidField,
    bool isSaving = false,
    UserEntity? saved,
    bool saveFailed = false,
  }) {
    return EditProfileState(
      status: status,
      user: user,
      invalidField: invalidField,
      isSaving: isSaving,
      saved: saved,
      saveFailed: saveFailed,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
    invalidField,
    isSaving,
    saved,
    saveFailed,
  ];
}
