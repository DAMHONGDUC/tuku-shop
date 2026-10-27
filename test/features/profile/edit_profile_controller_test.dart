import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/presentation/edit_profile/edit_profile_controller.dart';

import '../../helpers/mock_usecases.dart';

class _UpdateProfile extends Mock implements UpdateProfileUsecase {}

void main() {
  late MockGetCurrentUserUsecase getUser;
  late _UpdateProfile update;

  const user = UserEntity(
    id: 'u',
    fullName: 'Tuku Demo',
    email: 'demo@tukushop.com',
    phone: '0900000000',
    avatarUrl: '',
  );
  const renamed = UserEntity(
    id: 'u',
    fullName: 'Tuku Renamed',
    email: 'demo@tukushop.com',
    phone: '0900000000',
    avatarUrl: '',
  );
  const params = UpdateProfileParams(
    fullName: 'Tuku Renamed',
    phone: '0900000000',
  );
  const loaded = EditProfileState(status: EditProfileStatus.loaded, user: user);

  setUpAll(() => registerFallbackValue(params));

  setUp(() {
    getUser = MockGetCurrentUserUsecase();
    update = _UpdateProfile();
    when(
      () => getUser.call(NoParams()),
    ).thenAnswer((_) async => const Right(user));
  });

  EditProfileController build() => EditProfileController(getUser, update);

  blocTest<EditProfileController, EditProfileState>(
    'load reads the signed-in user',
    build: build,
    act: (c) => c.load(),
    expect: () => [const EditProfileState(), loaded],
  );

  blocTest<EditProfileController, EditProfileState>(
    'load fails to the error state',
    build: build,
    setUp: () => when(
      () => getUser.call(NoParams()),
    ).thenAnswer((_) async => Left(CacheFailure())),
    act: (c) => c.load(),
    expect: () => [
      const EditProfileState(),
      const EditProfileState(status: EditProfileStatus.error),
    ],
  );

  blocTest<EditProfileController, EditProfileState>(
    'save keeps the loaded user and reports the saved one',
    build: build,
    seed: () => loaded,
    setUp: () => when(
      () => update.call(params),
    ).thenAnswer((_) async => const Right(renamed)),
    act: (c) => c.save(fullName: 'Tuku Renamed', phone: '0900000000'),
    expect: () => [
      loaded.withSave(isSaving: true),
      loaded.withSave(saved: renamed),
    ],
  );

  blocTest<EditProfileController, EditProfileState>(
    'a validation failure marks the field',
    build: build,
    seed: () => loaded,
    setUp: () => when(
      () => update.call(any()),
    ).thenAnswer((_) async => const Left(ValidationFailure('full_name'))),
    act: (c) => c.save(fullName: '', phone: '0900000000'),
    expect: () => [
      loaded.withSave(isSaving: true),
      loaded.withSave(invalidField: 'full_name'),
    ],
  );
}
