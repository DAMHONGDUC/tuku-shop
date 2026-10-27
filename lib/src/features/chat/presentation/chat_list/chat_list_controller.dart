import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

part 'chat_list_state.dart';

/// The inbox: every thread, support first, then the most recent, each with
/// its shop's name and avatar. Follows new messages and reads.
class ChatListController extends Cubit<ChatListState> {
  ChatListController(
    this._getConversations,
    this._watchConversations,
    this._getSellersByIds,
  ) : super(const ChatListState()) {
    _subscription = _watchConversations().listen(_show);
  }

  final GetConversationsUsecase _getConversations;
  final WatchConversationsUsecase _watchConversations;
  final GetSellersByIdsUsecase _getSellersByIds;
  late final StreamSubscription<List<Conversation>> _subscription;

  Future<void> load() async {
    emit(state.copyWith(status: ChatListStatus.loading));
    final result = await _getConversations.call(NoParams());
    await result.fold(
      (_) async => emit(state.copyWith(status: ChatListStatus.error)),
      _show,
    );
  }

  Future<void> _show(List<Conversation> conversations) async {
    // Fetch only shops not already known.
    final missing = conversations
        .where((c) => !c.isSupport && !state.sellers.containsKey(c.peerId))
        .map((c) => c.peerId)
        .toSet()
        .toList();
    var sellers = state.sellers;
    if (missing.isNotEmpty) {
      final result = await _getSellersByIds.call(missing);
      if (isClosed) return;
      sellers = result.fold(
        (_) => sellers,
        (found) => {...sellers, for (final s in found) s.id: s},
      );
    }
    final ordered = [...conversations]
      ..sort((a, b) {
        if (a.isSupport != b.isSupport) return a.isSupport ? -1 : 1;
        return b.updatedAt.compareTo(a.updatedAt);
      });
    emit(
      ChatListState(
        status: ChatListStatus.loaded,
        conversations: ordered,
        sellers: sellers,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
