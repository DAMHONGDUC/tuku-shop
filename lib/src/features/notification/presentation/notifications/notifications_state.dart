part of 'notifications_controller.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = LoadStatus.loading,
    this.items = const <NotificationEntity>[],
  });

  final LoadStatus status;
  final List<NotificationEntity> items;

  bool get hasUnread => items.any((NotificationEntity n) => !n.isRead);

  @override
  List<Object> get props => <Object>[status, items];
}
