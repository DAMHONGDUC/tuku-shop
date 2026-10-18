import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/data/mock/auth_mock.dart';
import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  /// The saved session user, or `null` when signed out.
  ///
  /// The first call on a fresh install saves [AuthMock.defaultUser], so the
  /// demo opens already signed in.
  Future<UserModel?> getSessionUser();

  Future<void> saveSessionUser(UserModel user);

  Future<void> clearSession();

  /// Changes name and phone of the signed-in user; one request.
  Future<UserModel> updateSessionUser({
    required String fullName,
    required String phone,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kSessionUserKey = 'auth_session_user';
  static const kDefaultSessionSeededKey = 'auth_default_session_seeded';

  final SharedPreferencesAsync _prefs;

  @override
  Future<UserModel?> getSessionUser() async {
    try {
      final seeded = await _prefs.getBool(kDefaultSessionSeededKey) ?? false;
      if (!seeded) {
        await saveSessionUser(AuthMock.defaultUser);
        await _prefs.setBool(kDefaultSessionSeededKey, true);
      }

      final raw = await _prefs.getString(kSessionUserKey);
      if (raw == null) return null;

      return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> saveSessionUser(UserModel user) async {
    try {
      await _prefs.setString(kSessionUserKey, jsonEncode(user.toJson()));
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await _prefs.remove(kSessionUserKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<UserModel> updateSessionUser({
    required String fullName,
    required String phone,
  }) async {
    await MockLatency.wait();
    final current = await getSessionUser();
    if (current == null) throw const CacheException('signed out');
    final updated = UserModel(
      id: current.id,
      fullName: fullName,
      email: current.email,
      phone: phone,
      avatarUrl: current.avatarUrl,
    );
    await saveSessionUser(updated);
    return updated;
  }
}
