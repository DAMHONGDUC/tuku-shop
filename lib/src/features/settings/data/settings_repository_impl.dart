import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kLanguageKey = 'settings_language_code';

  final SharedPreferencesAsync _prefs;

  @override
  Future<Either<Failure, String?>> getLanguageCode() async {
    try {
      return Right(await _prefs.getString(kLanguageKey));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> setLanguageCode(String? code) async {
    try {
      code == null
          ? await _prefs.remove(kLanguageKey)
          : await _prefs.setString(kLanguageKey, code);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
