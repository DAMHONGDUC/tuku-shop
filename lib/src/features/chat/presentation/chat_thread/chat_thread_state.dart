part of 'chat_thread_controller.dart';

enum ChatThreadStatus { loading, loaded, error }

class ChatThreadState extends Equatable {
  final ChatThreadStatus status;
  final Conversation? conversation;

  /// The shop for a seller thread; null for support or while loading.
  final Seller? seller;

  /// Oldest first.
  final List<ChatMessage> messages;
  final bool isSending;

  /// True from a sent message until the answer lands.
  final bool peerTyping;

  /// Bumped when a message failed to send, for the error toast.
  final int failureCount;

  const ChatThreadState({
    this.status = ChatThreadStatus.loading,
    this.conversation,
    this.seller,
    this.messages = const [],
    this.isSending = false,
    this.peerTyping = false,
    this.failureCount = 0,
  });

  bool get isSupport => conversation?.isSupport ?? false;

  ChatThreadState copyWith({
    ChatThreadStatus? status,
    Conversation? conversation,
    Seller? seller,
    List<ChatMessage>? messages,
    bool? isSending,
    bool? peerTyping,
    int? failureCount,
  }) {
    return ChatThreadState(
      status: status ?? this.status,
      conversation: conversation ?? this.conversation,
      seller: seller ?? this.seller,
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      peerTyping: peerTyping ?? this.peerTyping,
      failureCount: failureCount ?? this.failureCount,
    );
  }

  @override
  List<Object?> get props => [
    status,
    conversation,
    seller,
    messages,
    isSending,
    peerTyping,
    failureCount,
  ];
}
