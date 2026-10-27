part of 'chat_list_controller.dart';

enum ChatListStatus { loading, loaded, error }

class ChatListState extends Equatable {
  final ChatListStatus status;

  /// Support first, then the most recent.
  final List<Conversation> conversations;

  /// The shops behind seller threads, by id.
  final Map<String, Seller> sellers;

  const ChatListState({
    this.status = ChatListStatus.loading,
    this.conversations = const [],
    this.sellers = const {},
  });

  ChatListState copyWith({ChatListStatus? status}) => ChatListState(
    status: status ?? this.status,
    conversations: conversations,
    sellers: sellers,
  );

  @override
  List<Object?> get props => [status, conversations, sellers];
}
