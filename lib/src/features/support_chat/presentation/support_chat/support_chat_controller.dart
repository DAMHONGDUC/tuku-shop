import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/support_chat/domain/domain.dart';

part 'support_chat_state.dart';

/// The support conversation. A sent message shows at once; the agent's
/// answer arrives later from the watch stream, with "typing" in between.
class SupportChatController extends Cubit<SupportChatState> {
  SupportChatController(
    this._getMessagesUsecase,
    this._sendMessageUsecase,
    this._watchMessagesUsecase,
  ) : super(const SupportChatState()) {
    _subscription = _watchMessagesUsecase().listen(
      (messages) => emit(
        state.copyWith(
          status: SupportChatStatus.loaded,
          messages: messages,
          agentTyping: false,
        ),
      ),
    );
  }

  final GetSupportMessagesUsecase _getMessagesUsecase;
  final SendSupportMessageUsecase _sendMessageUsecase;
  final WatchSupportMessagesUsecase _watchMessagesUsecase;
  late final StreamSubscription<List<ChatMessage>> _subscription;

  Future<void> load() async {
    emit(state.copyWith(status: SupportChatStatus.loading));
    final result = await _getMessagesUsecase.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(status: SupportChatStatus.error)),
      (messages) => emit(
        state.copyWith(status: SupportChatStatus.loaded, messages: messages),
      ),
    );
  }

  /// Returns false when [text] was not sent (empty, too long, or failed).
  Future<bool> send(String text) async {
    if (state.isSending || text.trim().isEmpty) return false;
    emit(state.copyWith(isSending: true));
    final result = await _sendMessageUsecase.call(text);
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
            agentTyping: true,
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
