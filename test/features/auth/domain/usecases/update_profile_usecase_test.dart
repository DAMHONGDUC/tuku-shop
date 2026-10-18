import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import '../../../../helpers/mock_repositories.dart';

void main() {
  late MockAuthRepository repository;
  late UpdateProfileUsecase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = UpdateProfileUsecase(repository);
  });

  test('rejects a one-letter name and a bad phone', () async {
    expect(
      await usecase.call(
        const UpdateProfileParams(fullName: 'T', phone: '+1 202 555 0147'),
      ),
      const Left(ValidationFailure('full_name')),
    );
    expect(
      await usecase.call(
        const UpdateProfileParams(fullName: 'Tuku', phone: 'abc'),
      ),
      const Left(ValidationFailure('phone')),
    );
    verifyZeroInteractions(repository);
  });

  test('trims and saves valid values', () async {
    const user = UserEntity(
      id: 'u',
      fullName: 'Tuku Demo',
      email: 'e',
      phone: '+1 202 555 0147',
      avatarUrl: '',
    );
    when(
      () => repository.updateProfile(
        fullName: 'Tuku Demo',
        phone: '+1 202 555 0147',
      ),
    ).thenAnswer((_) async => const Right(user));

    final result = await usecase.call(
      const UpdateProfileParams(
        fullName: ' Tuku Demo ',
        phone: '+1 202 555 0147 ',
      ),
    );

    expect(result, const Right(user));
  });
}
