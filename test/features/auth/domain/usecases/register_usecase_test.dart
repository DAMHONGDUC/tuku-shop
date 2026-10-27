import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import '../../../../helpers/mock_repositories.dart';

void main() {
  late MockAuthRepository repository;

  setUp(() => repository = MockAuthRepository());

  test('flags a short name, a bad email and a short password', () {
    expect(
      RegisterUsecase.validate(
        const RegisterParams(fullName: 'L', email: 'nope', password: '123'),
      ),
      RegisterField.values.toSet(),
    );
  });

  test('passes trimmed values to the repository', () async {
    const user = UserEntity(
      id: 'u',
      fullName: 'Linh',
      email: 'linh@example.com',
      phone: '',
      avatarUrl: '',
    );
    when(
      () => repository.register(
        fullName: 'Linh',
        email: 'linh@example.com',
        password: 'secret1',
      ),
    ).thenAnswer((_) async => const Right(user));

    final result = await RegisterUsecase(repository).call(
      const RegisterParams(
        fullName: ' Linh ',
        email: ' linh@example.com ',
        password: 'secret1',
      ),
    );

    expect(result, const Right(user));
  });

  test('invalid input never reaches the repository', () async {
    final result = await RegisterUsecase(repository).call(
      const RegisterParams(fullName: 'Linh', email: 'x', password: 'secret1'),
    );
    expect(result, const Left(ValidationFailure('email')));
    verifyZeroInteractions(repository);
  });
}
