import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Which shops the shopper follows, kept on the device.
abstract class SellerFollowLocalDataSource {
  Future<Set<String>> getFollowedIds();

  Future<void> saveFollowedIds(Set<String> ids);

  Future<void> reset();
}

class SellerFollowLocalDataSourceImpl implements SellerFollowLocalDataSource {
  SellerFollowLocalDataSourceImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kFollowedKey = 'followed_seller_ids';

  final SharedPreferencesAsync _prefs;

  @override
  Future<Set<String>> getFollowedIds() async {
    try {
      return (await _prefs.getStringList(kFollowedKey) ?? const []).toSet();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> saveFollowedIds(Set<String> ids) async {
    try {
      await MockLatency.wait();
      await _prefs.setStringList(kFollowedKey, ids.toList());
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> reset() async {
    try {
      await _prefs.remove(kFollowedKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
