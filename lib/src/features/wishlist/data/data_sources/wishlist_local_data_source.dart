import 'package:shared_preferences/shared_preferences.dart';

class WishlistLocalDataSource {
  const WishlistLocalDataSource(this.preferences);

  final SharedPreferences preferences;

  static const String _key = 'wishlist.ids';

  /// A first launch opens with a few saved pieces, so the tab is not empty
  /// in a demo.
  static const List<String> seed = <String>['wj01', 'mh02', 'wp02', '24-mb04'];

  List<String> read() => preferences.getStringList(_key) ?? seed;

  Future<void> write(List<String> ids) => preferences.setStringList(_key, ids);
}
