import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';

import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this.preferences);

  final SharedPreferences preferences;

  static const String _sessionKey = 'auth.session';

  @override
  Future<UserModel?> readSession() async {
    try {
      final String? raw = preferences.getString(_sessionKey);

      if (raw == null) return null;

      return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> saveSession(UserModel user) async {
    await preferences.setString(_sessionKey, jsonEncode(user.toJson()));
  }

  @override
  Future<void> clearSession() async {
    await preferences.remove(_sessionKey);
  }
}
