part of 'notifications_controller.dart';

/// The chips above the list.
enum NotificationFilter {
  all,
  orders,
  offers,
  updates;

  bool matches(NotificationType type) => switch (this) {
    NotificationFilter.all => true,
    NotificationFilter.orders => type == NotificationType.orderUpdate,
    NotificationFilter.offers =>
      type == NotificationType.promotion || type == NotificationType.newProduct,
    NotificationFilter.updates =>
      type == NotificationType.account || type == NotificationType.general,
  };
}

sealed class NotificationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoadingState extends NotificationsState {}

class NotificationsLoadedState extends NotificationsState {
  final NotificationData notificationData;
  final NotificationFilter filter;

  NotificationsLoadedState({
    required this.notificationData,
    this.filter = NotificationFilter.all,
  });

  List<NotificationEntity> get visible => notificationData.listNotification
      .where((e) => filter.matches(e.type))
      .toList();

  NotificationsLoadedState copyWith({NotificationFilter? filter}) =>
      NotificationsLoadedState(
        notificationData: notificationData,
        filter: filter ?? this.filter,
      );

  @override
  List<Object?> get props => [notificationData, filter];
}

class NotificationsErrorState extends NotificationsState {
  final String errorMsg;

  NotificationsErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
