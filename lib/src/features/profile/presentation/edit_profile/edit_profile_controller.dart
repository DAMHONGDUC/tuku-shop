import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

class EditProfileState extends Equatable {
  /// The field code that failed validation, if any.
  final String? invalidField;
  final bool isSaving;
  final UserEntity? saved;
  final bool saveFailed;

  const EditProfileState({
    this.invalidField,
    this.isSaving = false,
    this.saved,
    this.saveFailed = false,
  });

  @override
  List<Object?> get props => [invalidField, isSaving, saved, saveFailed];
}

class EditProfileController extends Cubit<EditProfileState> {
  EditProfileController(this._updateProfileUsecase)
    : super(const EditProfileState());

  final UpdateProfileUsecase _updateProfileUsecase;

  Future<void> save({required String fullName, required String phone}) async {
    emit(const EditProfileState(isSaving: true));
    final result = await _updateProfileUsecase.call(
      UpdateProfileParams(fullName: fullName, phone: phone),
    );
    result.fold(
      (failure) => emit(
        failure is ValidationFailure
            ? EditProfileState(invalidField: failure.message)
            : const EditProfileState(saveFailed: true),
      ),
      (user) => emit(EditProfileState(saved: user)),
    );
  }
}
