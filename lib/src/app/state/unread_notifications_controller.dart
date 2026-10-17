import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

/// The unread count on the home screen's bell.
class UnreadNotificationsController extends Cubit<int> {
  UnreadNotificationsController({required WatchUnreadCountUsecase watchUnread})
    : super(0) {
    _subscription = watchUnread(const NoParams()).listen(emit);
  }

  late final StreamSubscription<int> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
