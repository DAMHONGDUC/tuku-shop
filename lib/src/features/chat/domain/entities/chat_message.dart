import 'package:equatable/equatable.dart';

enum ChatSender { customer, peer }

/// One message in a conversation.
class ChatMessage extends Equatable {
  final String id;
  final String conversationId;
  final String text;
  final ChatSender sender;
  final DateTime sentAt;

  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.text,
    required this.sender,
    required this.sentAt,
  });

  bool get isMine => sender == ChatSender.customer;

  @override
  List<Object?> get props => [id, conversationId, text, sender, sentAt];
}
