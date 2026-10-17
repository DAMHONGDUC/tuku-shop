import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/data/mock/auth_mock.dart';
import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';

import 'auth_remote_data_source.dart';

/// A pretend auth server: the demo account plus anyone registered while the
/// app runs.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Map<String, ({UserModel user, String password})> _accounts =
      <String, ({UserModel user, String password})>{
        AuthMock.demoEmail: (
          user: AuthMock.demoUser,
          password: AuthMock.demoPassword,
        ),
      };

  @override
  ({String email, String password}) get demoCredentials =>
      (email: AuthMock.demoEmail, password: AuthMock.demoPassword);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await MockLatency.long();

    final ({UserModel user, String password})? account =
        _accounts[email.toLowerCase()];

    if (account == null || account.password != password) {
      throw const ValidationException(FailureCodes.invalidCredentials);
    }

    return account.user;
  }

  @override
  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await MockLatency.long();

    final String key = email.toLowerCase();

    if (_accounts.containsKey(key)) {
      throw const ValidationException(FailureCodes.emailTaken);
    }

    final UserModel user = UserModel(
      id: SdId.unique(),
      fullName: fullName,
      email: key,
      phone: '',
      memberSince: DateTime.now().toIso8601String(),
      points: 200,
    );
    _accounts[key] = (user: user, password: password);

    return user;
  }

  @override
  Future<UserModel> updateProfile({
    required String userId,
    required String fullName,
    required String email,
    required String phone,
  }) async {
    await MockLatency.normal();

    final MapEntry<String, ({UserModel user, String password})>? entry =
        _accounts.entries
            .where(
              (MapEntry<String, ({UserModel user, String password})> e) =>
                  e.value.user.id == userId,
            )
            .firstOrNull;
    final UserModel base = entry?.value.user ?? AuthMock.demoUser;
    final UserModel updated = base.copyWith(
      fullName: fullName,
      email: email,
      phone: phone,
    );

    if (entry != null) {
      _accounts.remove(entry.key);
      _accounts[email.toLowerCase()] = (
        user: updated,
        password: entry.value.password,
      );
    }

    return updated;
  }

  @override
  Future<void> requestPasswordReset(String email) => MockLatency.normal();
}
