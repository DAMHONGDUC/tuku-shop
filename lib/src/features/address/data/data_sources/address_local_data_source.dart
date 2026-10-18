import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/data/mock/address_mock.dart';
import 'package:tuku_shop/src/features/address/data/models/address_model.dart';

abstract class AddressLocalDataSource {
  Future<List<AddressModel>> getAll();

  /// Reads, applies [change] and stores the result; one request.
  Future<List<AddressModel>> mutate(
    List<AddressModel> Function(List<AddressModel>) change,
  );

  Future<void> reset();
}

class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  AddressLocalDataSourceImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kAddressesKey = 'addresses';

  final SharedPreferencesAsync _prefs;

  @override
  Future<List<AddressModel>> getAll() async {
    await MockLatency.wait();
    return _read();
  }

  @override
  Future<List<AddressModel>> mutate(
    List<AddressModel> Function(List<AddressModel>) change,
  ) async {
    await MockLatency.wait();
    final next = change(await _read());
    await _write(next);
    return next;
  }

  Future<List<AddressModel>> _read() async {
    try {
      final raw = await _prefs.getString(kAddressesKey);
      if (raw == null) {
        await _write(AddressMock.seed);
        return AddressMock.seed;
      }
      return (jsonDecode(raw) as List)
          .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  Future<void> _write(List<AddressModel> addresses) => _prefs.setString(
    kAddressesKey,
    jsonEncode(addresses.map((e) => e.toJson()).toList()),
  );

  @override
  Future<void> reset() async {
    try {
      await _prefs.remove(kAddressesKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
