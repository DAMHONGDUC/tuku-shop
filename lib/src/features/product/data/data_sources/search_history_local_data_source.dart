import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Keywords the user searched for, newest first, on this device.
abstract class SearchHistoryLocalDataSource {
  Future<List<String>> getRecent();

  Future<void> add(String keyword);

  Future<void> clear();
}

class SearchHistoryLocalDataSourceImpl implements SearchHistoryLocalDataSource {
  SearchHistoryLocalDataSourceImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kRecentSearchesKey = 'search_recent_keywords';
  static const maxItems = 8;

  final SharedPreferencesAsync _prefs;

  @override
  Future<List<String>> getRecent() async {
    try {
      return await _prefs.getStringList(kRecentSearchesKey) ?? [];
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> add(String keyword) async {
    try {
      final current = await getRecent();
      final next = [
        keyword,
        ...current.where((k) => k.toLowerCase() != keyword.toLowerCase()),
      ].take(maxItems).toList();
      await _prefs.setStringList(kRecentSearchesKey, next);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _prefs.remove(kRecentSearchesKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
