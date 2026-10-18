import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_model.dart';

/// Notifications the app raised itself, plus which ones were read.
abstract class NotificationLocalDataSource {
  Future<List<NotificationModel>> getAdded();

  Future<void> add(NotificationModel notification);

  Future<Set<String>> getReadIds();

  Future<void> saveReadIds(Set<String> ids);

  Future<void> reset();
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  NotificationLocalDataSourceImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  static const kAddedKey = 'notifications_added';
  static const kReadKey = 'notifications_read_ids';

  final SharedPreferencesAsync _prefs;

  @override
  Future<List<NotificationModel>> getAdded() async {
    try {
      final raw = await _prefs.getString(kAddedKey);
      if (raw == null) return [];
      return (jsonDecode(raw) as List).map((e) {
        final j = e as Map<String, dynamic>;
        return NotificationModel(
          id: j['id'] as String?,
          title: j['title'] as String?,
          body: j['body'] as String?,
          timestamp: DateTime.tryParse(j['timestamp'] as String? ?? ''),
          isRead: false,
          type: NotificationType.values.asNameMap()[j['type']],
          relatedItemId: j['relatedItemId'] as String?,
        );
      }).toList();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> add(NotificationModel n) async {
    try {
      await MockLatency.wait();
      final raw = await _prefs.getString(kAddedKey);
      final list = raw == null ? <dynamic>[] : jsonDecode(raw) as List;
      list.insert(0, {
        'id': n.id,
        'title': n.title,
        'body': n.body,
        'timestamp': n.timestamp?.toIso8601String(),
        'type': n.type?.name,
        'relatedItemId': n.relatedItemId,
      });
      await _prefs.setString(kAddedKey, jsonEncode(list));
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<Set<String>> getReadIds() async {
    try {
      return (await _prefs.getStringList(kReadKey) ?? const []).toSet();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> saveReadIds(Set<String> ids) async {
    try {
      await MockLatency.wait();
      await _prefs.setStringList(kReadKey, ids.toList());
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> reset() async {
    try {
      await _prefs.remove(kAddedKey);
      await _prefs.remove(kReadKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
