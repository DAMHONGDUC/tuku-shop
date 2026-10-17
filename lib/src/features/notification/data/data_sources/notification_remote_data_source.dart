import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/data/mock/notification_mock.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();

  Future<void> markRead(String id);

  Future<void> markAllRead();

  int get unreadCount;
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  NotificationRemoteDataSourceImpl({DateTime Function()? clock})
    : _items = NotificationMock.seed((clock ?? DateTime.now)());

  List<NotificationModel> _items;

  @override
  int get unreadCount =>
      _items.where((NotificationModel n) => n.isRead != true).length;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    await MockLatency.normal();
    return List<NotificationModel>.unmodifiable(_items);
  }

  @override
  Future<void> markRead(String id) async {
    _items = _items
        .map(
          (NotificationModel n) => n.id == id ? n.copyWith(isRead: true) : n,
        )
        .toList();
  }

  @override
  Future<void> markAllRead() async {
    await MockLatency.short();
    _items = _items
        .map((NotificationModel n) => n.copyWith(isRead: true))
        .toList();
  }
}
