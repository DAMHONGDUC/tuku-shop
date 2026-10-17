import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<UserModel> updateProfile({
    required String userId,
    required String fullName,
    required String email,
    required String phone,
  });

  Future<void> requestPasswordReset(String email);

  ({String email, String password}) get demoCredentials;
}
