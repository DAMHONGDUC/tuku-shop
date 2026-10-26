import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/domain/entities/chat_message.dart';
import 'package:tuku_shop/src/features/chat/domain/entities/conversation.dart';

/// New messages of one conversation, pushed when the other side answers.
typedef ChatThreadUpdate = ({
  String conversationId,
  List<ChatMessage> messages,
});

abstract class ChatRepository {
  /// Every thread, most recent first.
  Future<Either<Failure, List<Conversation>>> getConversations();

  /// Every thread each time one changes (a message, a read).
  Stream<List<Conversation>> watchConversations();

  /// The thread with [peerId], started if it does not exist yet.
  Future<Either<Failure, Conversation>> openConversation(String peerId);

  /// One thread's messages, oldest first.
  Future<Either<Failure, List<ChatMessage>>> getMessages(String conversationId);

  /// A thread's messages each time the other side answers.
  Stream<ChatThreadUpdate> watchMessages();

  /// Sends [text]; returns the stored message. The answer arrives later
  /// through [watchMessages].
  Future<Either<Failure, ChatMessage>> send(String conversationId, String text);

  /// Clears the thread's unread count.
  Future<Either<Failure, Unit>> markRead(String conversationId);

  /// Back to the first-launch threads.
  Future<Either<Failure, Unit>> reset();
}
