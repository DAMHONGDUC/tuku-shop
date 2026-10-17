part of 'profile_controller.dart';

sealed class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final List<SettingSectionEntity> listSettingSection;

  ProfileLoadedState({required this.listSettingSection});

  @override
  List<Object?> get props => [listSettingSection];
}

class ProfileErrorState extends ProfileState {
  final String errorMsg;

  ProfileErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class ProfileLoggedOutState extends ProfileState {}

class ProfileLogoutFailedState extends ProfileState {}
