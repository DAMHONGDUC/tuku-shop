import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/mock/order_mock.dart';
import 'package:tuku_shop/src/features/order/data/models/order_model.dart';

/// Orders as the "server" keeps them; stored on the device for the demo.
abstract class OrderLocalDataSource {
  /// Every order, newest first.
  Future<List<OrderModel>> getAll();

  /// Stores [draft] with the next order number; one request.
  Future<OrderModel> insert(OrderModel draft);

  /// Applies [change] to order [id] and stores it; one request. Throws
  /// [ValidationException] when the order does not exist.
  Future<OrderModel> update(String id, OrderModel Function(OrderModel) change);

  Future<void> reset();
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  OrderLocalDataSourceImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kOrdersKey = 'orders';

  final SharedPreferencesAsync _prefs;

  @override
  Future<List<OrderModel>> getAll() async {
    await MockLatency.wait();
    return _read();
  }

  @override
  Future<OrderModel> insert(OrderModel draft) async {
    await MockLatency.wait();
    final all = await _read();
    final last = all
        .map((o) => int.tryParse((o.id ?? '').replaceFirst('TK', '')) ?? 0)
        .fold(OrderMock.firstOrderNumber - 1, (a, b) => a > b ? a : b);
    final stored = draft.copyWith(id: 'TK${last + 1}');
    await _write([stored, ...all]);
    return stored;
  }

  @override
  Future<OrderModel> update(
    String id,
    OrderModel Function(OrderModel) change,
  ) async {
    await MockLatency.wait();
    final all = await _read();
    final current = all.where((o) => o.id == id).firstOrNull;
    if (current == null) throw const ValidationException('not_found');
    final updated = change(current);
    await _write([for (final o in all) o.id == id ? updated : o]);
    return updated;
  }

  Future<List<OrderModel>> _read() async {
    try {
      final raw = await _prefs.getString(kOrdersKey);
      if (raw == null) {
        final seed = OrderMock.seed();
        await _write(seed);
        return seed;
      }
      return (jsonDecode(raw) as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  Future<void> _write(List<OrderModel> orders) => _prefs.setString(
    kOrdersKey,
    jsonEncode(orders.map((e) => e.toJson()).toList()),
  );

  @override
  Future<void> reset() async {
    try {
      await _prefs.remove(kOrdersKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
