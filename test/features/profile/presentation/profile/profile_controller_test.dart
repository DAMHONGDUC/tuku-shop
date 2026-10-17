import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/profile/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/profile_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetProfileSettingsUsecase usecase;
  late MockLogoutUsecase logoutUsecase;
  late ProfileController controller;

  final tSections = [
    SettingSectionEntity(
      name: 'Account',
      sectionType: SettingSectionType.general,
      items: const [],
    ),
  ];

  setUp(() {
    usecase = MockGetProfileSettingsUsecase();
    logoutUsecase = MockLogoutUsecase();
    controller = ProfileController(usecase, logoutUsecase);
  });

  tearDown(() => controller.close());

  blocTest<ProfileController, ProfileState>(
    'emits [Loading, Loaded] when the usecase succeeds',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => Right(tSections));
    },
    build: () => controller,
    act: (c) => c.getData(),
    expect: () => [
      ProfileLoadingState(),
      ProfileLoadedState(listSettingSection: tSections),
    ],
  );

  blocTest<ProfileController, ProfileState>(
    'emits [Loading, Error] when the usecase fails',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => controller,
    act: (c) => c.getData(),
    expect: () => [
      ProfileLoadingState(),
      ProfileErrorState(errorMsg: 'something wrong'),
    ],
  );

  blocTest<ProfileController, ProfileState>(
    'emits [LoggedOut] when the logout item is tapped and logout succeeds',
    setUp: () {
      when(
        () => logoutUsecase.call(NoParams()),
      ).thenAnswer((_) async => const Right(unit));
    },
    build: () => controller,
    act: (c) => c.onSettingTapped(SettingItemType.logout),
    expect: () => [ProfileLoggedOutState()],
  );

  blocTest<ProfileController, ProfileState>(
    'emits [LogoutFailed] when logout fails',
    setUp: () {
      when(
        () => logoutUsecase.call(NoParams()),
      ).thenAnswer((_) async => Left(CacheFailure()));
    },
    build: () => controller,
    act: (c) => c.logout(),
    expect: () => [ProfileLogoutFailedState()],
  );

  blocTest<ProfileController, ProfileState>(
    'does nothing for a setting item other than logout',
    build: () => controller,
    act: (c) => c.onSettingTapped(SettingItemType.editProfile),
    expect: () => <ProfileState>[],
    verify: (_) => verifyNever(() => logoutUsecase.call(NoParams())),
  );
}
