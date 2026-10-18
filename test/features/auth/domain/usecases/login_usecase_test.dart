import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import '../../../../helpers/mock_repositories.dart';

void main() {
  late MockAuthRepository repository;
  late LoginUsecase usecase;

  const tUser = UserEntity(
    id: 'u-1',
    fullName: 'Demo',
    email: 'a@b.com',
    phone: '',
    avatarUrl: '',
  );

  setUp(() {
    repository = MockAuthRepository();
    usecase = LoginUsecase(repository);
  });

  test('trims the email before calling the repository', () async {
    when(
      () => repository.login(email: 'a@b.com', password: 'pw'),
    ).thenAnswer((_) async => const Right(tUser));

    final result = await usecase.call(
      const LoginParams(email: '  a@b.com ', password: 'pw'),
    );

    expect(result, const Right(tUser));
    verify(() => repository.login(email: 'a@b.com', password: 'pw')).called(1);
  });
}
