import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_model.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

class NotificationModelToNotificationEntityMapper {
  const NotificationModelToNotificationEntityMapper._();

  static NotificationEntity toEntity(NotificationModel model) =>
      NotificationEntity(
        id: model.id ?? '',
        type: NotificationType.fromName(model.type),
        title: model.title ?? '',
        body: model.body ?? '',
        createdAt: model.createdAt ?? DateTime(2026),
        isRead: model.isRead ?? false,
        image: model.image,
        link: model.link,
      );
}
