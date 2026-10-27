import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/domain/entities/chat_message.dart';
import 'package:tuku_shop/src/features/chat/domain/entities/conversation.dart';
import 'package:tuku_shop/src/features/chat/domain/repositories/chat_repository.dart';

class GetConversationsUsecase implements UseCase<List<Conversation>, NoParams> {
  final ChatRepository repository;

  GetConversationsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Conversation>>> call(NoParams params) =>
      repository.getConversations();
}

/// A stream, not an `Either`: the inbox and badge follow every change.
class WatchConversationsUsecase {
  final ChatRepository repository;

  WatchConversationsUsecase(this.repository);

  Stream<List<Conversation>> call() => repository.watchConversations();
}

class OpenConversationUsecase implements UseCase<Conversation, String> {
  final ChatRepository repository;

  OpenConversationUsecase(this.repository);

  @override
  Future<Either<Failure, Conversation>> call(String params) =>
      repository.openConversation(params);
}

class GetChatMessagesUsecase implements UseCase<List<ChatMessage>, String> {
  final ChatRepository repository;

  GetChatMessagesUsecase(this.repository);

  @override
  Future<Either<Failure, List<ChatMessage>>> call(String params) =>
      repository.getMessages(params);
}

/// A stream, not an `Either`: answers arrive whenever they are ready.
class WatchChatMessagesUsecase {
  final ChatRepository repository;

  WatchChatMessagesUsecase(this.repository);

  Stream<ChatThreadUpdate> call() => repository.watchMessages();
}

class SendChatMessageUsecase implements UseCase<ChatMessage, SendChatParams> {
  final ChatRepository repository;

  SendChatMessageUsecase(this.repository);

  /// Longest message a shop or the desk accepts.
  static const maxLength = 1000;

  @override
  Future<Either<Failure, ChatMessage>> call(SendChatParams params) {
    final text = params.text.trim();
    if (text.isEmpty || text.length > maxLength) {
      return Future.value(const Left(ValidationFailure('invalid_message')));
    }
    return repository.send(params.conversationId, text);
  }
}

class SendChatParams extends Equatable {
  final String conversationId;
  final String text;

  const SendChatParams({required this.conversationId, required this.text});

  @override
  List<Object?> get props => [conversationId, text];
}

class MarkConversationReadUsecase implements UseCase<Unit, String> {
  final ChatRepository repository;

  MarkConversationReadUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String params) =>
      repository.markRead(params);
}

class ResetChatUsecase implements UseCase<Unit, NoParams> {
  final ChatRepository repository;

  ResetChatUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.reset();
}
