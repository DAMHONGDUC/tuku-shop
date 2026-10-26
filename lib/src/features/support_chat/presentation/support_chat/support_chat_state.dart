part of 'support_chat_controller.dart';

enum SupportChatStatus { loading, loaded, error }

class SupportChatState extends Equatable {
  final SupportChatStatus status;

  /// Oldest first.
  final List<ChatMessage> messages;
  final bool isSending;

  /// True from a sent message until the agent's answer lands.
  final bool agentTyping;

  /// Bumped when a message failed to send, for the error toast.
  final int failureCount;

  const SupportChatState({
    this.status = SupportChatStatus.loading,
    this.messages = const [],
    this.isSending = false,
    this.agentTyping = false,
    this.failureCount = 0,
  });

  SupportChatState copyWith({
    SupportChatStatus? status,
    List<ChatMessage>? messages,
    bool? isSending,
    bool? agentTyping,
    int? failureCount,
  }) {
    return SupportChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      agentTyping: agentTyping ?? this.agentTyping,
      failureCount: failureCount ?? this.failureCount,
    );
  }

  @override
  List<Object?> get props => [
    status,
    messages,
    isSending,
    agentTyping,
    failureCount,
  ];
}
