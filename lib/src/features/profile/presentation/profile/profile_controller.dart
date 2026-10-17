import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileController extends Cubit<ProfileState> {
  ProfileController(this._getProfileSettingsUsecase, this._logoutUsecase)
    : super(ProfileInitial());

  final GetProfileSettingsUsecase _getProfileSettingsUsecase;
  final LogoutUsecase _logoutUsecase;

  Future getData() async {
    emit(ProfileLoadingState());

    final result = await _getProfileSettingsUsecase.call(NoParams());

    result.fold(
      (l) {
        emit(ProfileErrorState(errorMsg: 'something wrong'));
      },
      (r) {
        emit(ProfileLoadedState(listSettingSection: r));
      },
    );
  }

  Future<void> onSettingTapped(SettingItemType type) async {
    if (type == SettingItemType.logout) await logout();
  }

  Future<void> logout() async {
    final result = await _logoutUsecase.call(NoParams());

    result.fold(
      (_) => emit(ProfileLogoutFailedState()),
      (_) => emit(ProfileLoggedOutState()),
    );
  }
}
