import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

/// Unread notifications for the bell; refreshes after every change.
class NotificationBadgeController extends Cubit<int> {
  NotificationBadgeController(this._getUnreadCount, this._watchChanges)
    : super(0) {
    _subscription = _watchChanges().listen((_) => load());
  }

  final GetUnreadNotificationCountUsecase _getUnreadCount;
  final WatchNotificationChangesUsecase _watchChanges;
  late final StreamSubscription<void> _subscription;

  Future<void> load() async {
    final result = await _getUnreadCount.call(NoParams());
    result.fold((_) {}, emit);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
