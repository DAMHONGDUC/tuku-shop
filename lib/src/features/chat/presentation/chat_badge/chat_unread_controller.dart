import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';

/// Unread messages across every thread, for the Chat tab badge. App-wide.
class ChatUnreadController extends Cubit<int> {
  ChatUnreadController(this._getConversations, this._watchConversations)
    : super(0) {
    _subscription = _watchConversations().listen(_count);
  }

  final GetConversationsUsecase _getConversations;
  final WatchConversationsUsecase _watchConversations;
  late final StreamSubscription<List<Conversation>> _subscription;

  void _count(List<Conversation> conversations) =>
      emit(conversations.fold(0, (sum, c) => sum + c.unreadCount));

  Future<void> load() async {
    final result = await _getConversations.call(NoParams());
    result.fold((_) {}, _count);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
