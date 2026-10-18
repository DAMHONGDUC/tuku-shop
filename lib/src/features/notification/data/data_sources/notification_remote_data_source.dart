import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/data/mock/notifications_mock.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_category_model.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<List<NotificationCategoryModel>> getNotificationCategories();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl();

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      await MockLatency.wait();
      return NotificationsMock.generateMockNotifications();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<NotificationCategoryModel>> getNotificationCategories() async {
    try {
      await MockLatency.wait();
      return NotificationsMock.generateMockCategories();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
