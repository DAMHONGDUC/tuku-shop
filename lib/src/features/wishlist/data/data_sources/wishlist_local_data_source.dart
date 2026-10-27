import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/wishlist/data/mock/wishlist_mock.dart';

abstract class WishlistLocalDataSource {
  Future<List<String>> getIds();

  Future<void> saveIds(List<String> ids);

  /// Back to the first-launch seed.
  Future<void> reset();
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  WishlistLocalDataSourceImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kIdsKey = 'wishlist_product_ids';

  final SharedPreferencesAsync _prefs;

  @override
  Future<List<String>> getIds() async {
    try {
      await MockLatency.wait();
      final saved = await _prefs.getStringList(kIdsKey);
      if (saved != null) return saved;
      await _prefs.setStringList(kIdsKey, WishlistMock.seedIds);
      return WishlistMock.seedIds;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> saveIds(List<String> ids) async {
    try {
      await MockLatency.wait();
      await _prefs.setStringList(kIdsKey, ids);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> reset() async {
    try {
      await _prefs.remove(kIdsKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
