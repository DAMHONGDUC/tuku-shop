part of 'profile_controller.dart';

enum ProfileSectionStatus { loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileSectionStatus userStatus;
  final UserEntity? user;
  final ProfileSectionStatus countsStatus;
  final Map<OrderStatus, int> counts;
  final bool isResetting;

  /// Bumped after each finished reset, for the confirmation toast.
  final int resets;
  final bool loggedOut;
  final bool logoutFailed;

  const ProfileState({
    this.userStatus = ProfileSectionStatus.loading,
    this.user,
    this.countsStatus = ProfileSectionStatus.loading,
    this.counts = const {},
    this.isResetting = false,
    this.resets = 0,
    this.loggedOut = false,
    this.logoutFailed = false,
  });

  ProfileState copyWith({
    ProfileSectionStatus? userStatus,
    UserEntity? user,
    ProfileSectionStatus? countsStatus,
    Map<OrderStatus, int>? counts,
    bool? isResetting,
    int? resets,
    bool? loggedOut,
    bool? logoutFailed,
  }) {
    return ProfileState(
      userStatus: userStatus ?? this.userStatus,
      user: user ?? this.user,
      countsStatus: countsStatus ?? this.countsStatus,
      counts: counts ?? this.counts,
      isResetting: isResetting ?? this.isResetting,
      resets: resets ?? this.resets,
      loggedOut: loggedOut ?? this.loggedOut,
      logoutFailed: logoutFailed ?? this.logoutFailed,
    );
  }

  @override
  List<Object?> get props => [
    userStatus,
    user,
    countsStatus,
    counts,
    isResetting,
    resets,
    loggedOut,
    logoutFailed,
  ];
}
