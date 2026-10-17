import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

part 'notifications_state.dart';

class NotificationsController extends Cubit<NotificationsState> {
  NotificationsController({
    required this._getNotifications,
    required this._markRead,
    required this._markAllRead,
  }) : super(const NotificationsState());

  final GetNotificationsUsecase _getNotifications;
  final MarkNotificationReadUsecase _markRead;
  final MarkAllNotificationsReadUsecase _markAllRead;

  Future<void> load() async {
    final Either<Failure, List<NotificationEntity>> result =
        await _getNotifications(const NoParams());
    result.fold(
      (Failure _) => emit(const NotificationsState(status: LoadStatus.failure)),
      (List<NotificationEntity> items) =>
          emit(NotificationsState(status: LoadStatus.success, items: items)),
    );
  }

  Future<void> markRead(String id) async {
    _set((NotificationEntity n) => n.id == id ? n.copyWith(isRead: true) : n);
    await _markRead(id);
  }

  Future<void> markAllRead() async {
    _set((NotificationEntity n) => n.copyWith(isRead: true));
    await _markAllRead(const NoParams());
  }

  void _set(NotificationEntity Function(NotificationEntity) update) => emit(
    NotificationsState(
      status: state.status,
      items: state.items.map(update).toList(),
    ),
  );
}
