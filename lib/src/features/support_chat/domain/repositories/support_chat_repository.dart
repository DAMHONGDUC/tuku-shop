import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/support_chat/domain/entities/chat_message.dart';

abstract class SupportChatRepository {
  /// The whole conversation, oldest first.
  Future<Either<Failure, List<ChatMessage>>> getMessages();

  /// Sends [text]; returns the stored message. The agent's answer arrives
  /// later through [watchMessages].
  Future<Either<Failure, ChatMessage>> send(String text);

  /// The whole conversation each time the agent answers.
  Stream<List<ChatMessage>> watchMessages();

  /// Back to the first-launch greeting.
  Future<Either<Failure, Unit>> reset();
}
