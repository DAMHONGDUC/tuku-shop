import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

part 'chat_thread_state.dart';

/// One thread with the support desk or a shop. Opening it starts the thread
/// if needed and marks it read; a sent message shows at once, the answer
/// arrives from the watch stream with "typing" in between.
class ChatThreadController extends Cubit<ChatThreadState> {
  ChatThreadController(
    this._openConversation,
    this._getMessages,
    this._watchMessages,
    this._sendMessage,
    this._markRead,
    this._getSeller,
  ) : super(const ChatThreadState()) {
    _subscription = _watchMessages().listen((update) {
      if (update.conversationId != state.conversation?.id) return;
      emit(state.copyWith(messages: update.messages, peerTyping: false));
      _markRead.call(update.conversationId);
    });
  }

  final OpenConversationUsecase _openConversation;
  final GetChatMessagesUsecase _getMessages;
  final WatchChatMessagesUsecase _watchMessages;
  final SendChatMessageUsecase _sendMessage;
  final MarkConversationReadUsecase _markRead;
  final GetSellerUsecase _getSeller;
  late final StreamSubscription<ChatThreadUpdate> _subscription;

  Future<void> open(String peerId) async {
    emit(const ChatThreadState());
    final opened = await _openConversation.call(peerId);
    if (isClosed) return;
    await opened.fold(
      (_) async => emit(state.copyWith(status: ChatThreadStatus.error)),
      (conversation) async {
        emit(state.copyWith(conversation: conversation));
        // Messages and the shop's card load side by side.
        final messagesRequest = _getMessages.call(conversation.id);
        final sellerRequest = conversation.isSupport
            ? null
            : _getSeller.call(conversation.peerId);
        final messages = await messagesRequest;
        final seller = await sellerRequest;
        if (isClosed) return;
        messages.fold(
          (_) => emit(state.copyWith(status: ChatThreadStatus.error)),
          (list) => emit(
            state.copyWith(
              status: ChatThreadStatus.loaded,
              messages: list,
              seller: seller?.toOption().toNullable(),
            ),
          ),
        );
        if (conversation.unreadCount > 0) _markRead.call(conversation.id);
      },
    );
  }

  /// Returns false when [text] was not sent (empty, too long, or failed).
  Future<bool> send(String text) async {
    final conversation = state.conversation;
    if (conversation == null || state.isSending || text.trim().isEmpty) {
      return false;
    }
    emit(state.copyWith(isSending: true));
    final result = await _sendMessage.call(
      SendChatParams(conversationId: conversation.id, text: text),
    );
    if (isClosed) return false;
    return result.fold(
      (_) {
        emit(
          state.copyWith(
            isSending: false,
            failureCount: state.failureCount + 1,
          ),
        );
        return false;
      },
      (sent) {
        emit(
          state.copyWith(
            isSending: false,
            peerTyping: true,
            messages: [...state.messages, sent],
          ),
        );
        return true;
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
