import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_state.dart';

class NotificationsController extends Cubit<NotificationsState> {
  NotificationsController(
    this._getNotificationsUsecase,
    this._markAllReadUsecase,
  ) : super(NotificationsInitial());

  final GetNotificationsUsecase _getNotificationsUsecase;
  final MarkAllNotificationsReadUsecase _markAllReadUsecase;

  Future getData() async {
    emit(NotificationsLoadingState());

    final result = await _getNotificationsUsecase.call(NoParams());

    result.fold(
      (l) {
        emit(NotificationsErrorState(errorMsg: 'something wrong'));
      },
      (r) {
        emit(NotificationsLoadedState(notificationData: r));
        // Seen once listed; the bell badge clears.
        _markAllReadUsecase.call(NoParams());
      },
    );
  }

  void selectFilter(NotificationFilter filter) {
    final current = state;
    if (current is NotificationsLoadedState) {
      emit(current.copyWith(filter: filter));
    }
  }
}
