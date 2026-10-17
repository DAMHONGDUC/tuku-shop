import 'package:shared_preferences/shared_preferences.dart';

/// Recent search terms, newest first, kept on the device.
class ProductLocalDataSource {
  const ProductLocalDataSource(this.preferences);

  final SharedPreferences preferences;

  static const String _recentKey = 'search.recent';
  static const int maxRecent = 8;

  List<String> readRecent() =>
      preferences.getStringList(_recentKey) ?? const <String>[];

  Future<List<String>> addRecent(String keyword) async {
    final List<String> next = <String>[
      keyword,
      ...readRecent().where(
        (String k) => k.toLowerCase() != keyword.toLowerCase(),
      ),
    ].take(maxRecent).toList();

    await preferences.setStringList(_recentKey, next);
    return next;
  }

  Future<void> clearRecent() => preferences.remove(_recentKey);
}
