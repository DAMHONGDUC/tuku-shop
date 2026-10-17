import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';

/// The session kept on the device between launches.
abstract class AuthLocalDataSource {
  Future<UserModel?> readSession();

  Future<void> saveSession(UserModel user);

  Future<void> clearSession();
}
