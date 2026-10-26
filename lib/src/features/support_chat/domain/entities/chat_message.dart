import 'package:equatable/equatable.dart';

enum ChatSender { customer, agent }

/// One message in the support conversation.
class ChatMessage extends Equatable {
  final String id;
  final String text;
  final ChatSender sender;
  final DateTime sentAt;

  /// The support agent's display name; empty for the customer.
  final String agentName;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.sentAt,
    this.agentName = '',
  });

  bool get isMine => sender == ChatSender.customer;

  @override
  List<Object?> get props => [id, text, sender, sentAt, agentName];
}
