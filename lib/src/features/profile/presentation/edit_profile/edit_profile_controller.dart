import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

part 'edit_profile_state.dart';

/// Loads the signed-in user itself, so the route carries no `extra` (the
/// router's codec only encodes plain values).
class EditProfileController extends Cubit<EditProfileState> {
  EditProfileController(this._getCurrentUserUsecase, this._updateProfileUsecase)
    : super(const EditProfileState());

  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;

  Future<void> load() async {
    emit(const EditProfileState());
    final result = await _getCurrentUserUsecase.call(NoParams());
    result.fold(
      (_) => emit(const EditProfileState(status: EditProfileStatus.error)),
      (user) =>
          emit(EditProfileState(status: EditProfileStatus.loaded, user: user)),
    );
  }

  Future<void> save({required String fullName, required String phone}) async {
    emit(state.withSave(isSaving: true));
    final result = await _updateProfileUsecase.call(
      UpdateProfileParams(fullName: fullName, phone: phone),
    );
    result.fold(
      (failure) => emit(
        failure is ValidationFailure
            ? state.withSave(invalidField: failure.message)
            : state.withSave(saveFailed: true),
      ),
      (user) => emit(state.withSave(saved: user)),
    );
  }
}
