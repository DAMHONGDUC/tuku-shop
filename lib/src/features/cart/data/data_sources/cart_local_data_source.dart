import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/data/mock/cart_mock.dart';
import 'package:tuku_shop/src/features/cart/data/models/cart_line_model.dart';

/// The cart as the "server" keeps it; stored on the device for the demo.
abstract class CartLocalDataSource {
  Future<List<CartLineModel>> getLines();

  Future<void> saveLines(List<CartLineModel> lines);

  Future<void> reset();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kLinesKey = 'cart_lines';

  final SharedPreferencesAsync _prefs;

  @override
  Future<List<CartLineModel>> getLines() async {
    try {
      await MockLatency.wait();
      final raw = await _prefs.getString(kLinesKey);
      if (raw == null) {
        await _write(CartMock.seedLines);
        return CartMock.seedLines;
      }
      return (jsonDecode(raw) as List)
          .map((e) => CartLineModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> saveLines(List<CartLineModel> lines) async {
    try {
      await MockLatency.wait();
      await _write(lines);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  Future<void> _write(List<CartLineModel> lines) => _prefs.setString(
    kLinesKey,
    jsonEncode(lines.map((e) => e.toJson()).toList()),
  );

  @override
  Future<void> reset() async {
    try {
      await _prefs.remove(kLinesKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
