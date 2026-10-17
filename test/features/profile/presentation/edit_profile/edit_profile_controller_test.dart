import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/presentation/edit_profile/edit_profile_controller.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockUpdateProfileUsecase updateProfile;

  const UpdateProfileParams params = UpdateProfileParams(
    fullName: 'Alex Morgan',
    email: 'alex@example.com',
    phone: '+1 (415) 555-0132',
  );

  setUpAll(() => registerFallbackValue(params));

  setUp(() => updateProfile = MockUpdateProfileUsecase());

  Future<void> submit(EditProfileController c) => c.submit(
    fullName: params.fullName,
    email: params.email,
    phone: params.phone,
  );

  blocTest<EditProfileController, EditProfileState>(
    'invalid fields are flagged and nothing is saved',
    build: () => EditProfileController(updateProfile: updateProfile),
    act: (EditProfileController c) =>
        c.submit(fullName: '', email: 'alex@', phone: '12'),
    expect: () => <EditProfileState>[
      const EditProfileState(
        nameError: EditProfileFieldError.required,
        emailError: EditProfileFieldError.invalidEmail,
        phoneError: EditProfileFieldError.invalidPhone,
      ),
    ],
    verify: (_) => verifyNever(() => updateProfile(any())),
  );

  blocTest<EditProfileController, EditProfileState>(
    'valid fields save',
    build: () {
      when(
        () => updateProfile(any()),
      ).thenAnswer((_) async => Right<Failure, UserEntity>(Fixtures.user));
      return EditProfileController(updateProfile: updateProfile);
    },
    act: submit,
    expect: () => <EditProfileState>[
      const EditProfileState(),
      const EditProfileState(submitting: true),
      const EditProfileState(saved: true),
    ],
    verify: (_) => verify(() => updateProfile(params)).called(1),
  );

  blocTest<EditProfileController, EditProfileState>(
    'a failed save surfaces the failure',
    build: () {
      when(() => updateProfile(any())).thenAnswer(
        (_) async => const Left<Failure, UserEntity>(ServerFailure()),
      );
      return EditProfileController(updateProfile: updateProfile);
    },
    act: submit,
    expect: () => <EditProfileState>[
      const EditProfileState(),
      const EditProfileState(submitting: true),
      const EditProfileState(failure: ServerFailure()),
    ],
  );
}
