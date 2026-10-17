import 'package:tuku_shop/src/features/auth/data/mock/auth_mock.dart';
import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';
import 'package:tuku_shop/src/features/auth/domain/entities/demo_account.dart';
import 'package:tuku_shop/src/core/core.dart';

abstract class AuthRemoteDataSource {
  /// Throws [InvalidCredentialsException] on a wrong email or password.
  Future<UserModel> login({required String email, required String password});
}

class InvalidCredentialsException implements Exception {
  const InvalidCredentialsException();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await MockLatency.wait();

    final isValid =
        email.toLowerCase() == DemoAccount.email &&
        password == DemoAccount.password;
    if (!isValid) throw const InvalidCredentialsException();

    return AuthMock.defaultUser;
  }
}
