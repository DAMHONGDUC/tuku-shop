import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

part 'edit_profile_state.dart';

class EditProfileController extends Cubit<EditProfileState> {
  EditProfileController({required this._updateProfile})
    : super(const EditProfileState());

  final UpdateProfileUsecase _updateProfile;

  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Digits with the usual separators, at least 7 digits in all.
  static final RegExp _phone = RegExp(r'^\+?[\d\s().-]{7,}$');

  Future<void> submit({
    required String fullName,
    required String email,
    required String phone,
  }) async {
    final EditProfileFieldError? nameError = fullName.trim().isEmpty
        ? EditProfileFieldError.required
        : null;
    final EditProfileFieldError? emailError = _email.hasMatch(email.trim())
        ? null
        : EditProfileFieldError.invalidEmail;
    final EditProfileFieldError? phoneError = _phone.hasMatch(phone.trim())
        ? null
        : EditProfileFieldError.invalidPhone;

    emit(
      state.copyWith(
        nameError: () => nameError,
        emailError: () => emailError,
        phoneError: () => phoneError,
        failure: () => null,
      ),
    );

    if (<Object?>[
      nameError,
      emailError,
      phoneError,
    ].any((Object? e) => e != null)) {
      return;
    }

    emit(state.copyWith(submitting: true));

    final Either<Failure, UserEntity> result = await _updateProfile(
      UpdateProfileParams(fullName: fullName, email: email, phone: phone),
    );

    result.fold(
      (Failure f) => emit(state.copyWith(submitting: false, failure: () => f)),
      (UserEntity _) => emit(state.copyWith(submitting: false, saved: true)),
    );
  }
}
