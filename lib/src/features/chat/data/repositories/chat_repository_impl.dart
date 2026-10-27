import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:tuku_shop/src/features/chat/data/mapper/chat_mappers.dart';
import 'package:tuku_shop/src/features/chat/data/models/chat_models.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({required this.dataSource});

  final ChatLocalDataSource dataSource;
  final _conversations = StreamController<List<Conversation>>.broadcast();
  final _threads = StreamController<ChatThreadUpdate>.broadcast();

  static List<Conversation> _sorted(List<ConversationModel> models) =>
      models.map(ConversationModelToConversationMapper.toEntity).toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  Future<void> _pushConversations() async {
    _conversations.add(_sorted(await dataSource.getConversations()));
  }

  @override
  Stream<List<Conversation>> watchConversations() => _conversations.stream;

  @override
  Stream<ChatThreadUpdate> watchMessages() => _threads.stream;

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      return Right(_sorted(await dataSource.getConversations()));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Conversation>> openConversation(String peerId) async {
    try {
      final model = await dataSource.openConversation(peerId);
      unawaited(_pushConversations());
      return Right(ConversationModelToConversationMapper.toEntity(model));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> getMessages(
    String conversationId,
  ) async {
    try {
      final models = await dataSource.getMessages(conversationId);
      return Right(
        models.map(ChatMessageModelToChatMessageMapper.toEntity).toList(),
      );
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ChatMessage>> send(
    String conversationId,
    String text,
  ) async {
    try {
      final sent = await dataSource.send(conversationId, text);
      unawaited(_pushConversations());
      // The other side answers on its own time, like a push from the API.
      unawaited(_deliverReply(conversationId, text));
      return Right(ChatMessageModelToChatMessageMapper.toEntity(sent));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<void> _deliverReply(String conversationId, String text) async {
    try {
      await dataSource.awaitReply(conversationId, text);
      final messages = await dataSource.getMessages(conversationId);
      _threads.add((
        conversationId: conversationId,
        messages: messages
            .map(ChatMessageModelToChatMessageMapper.toEntity)
            .toList(),
      ));
      await _pushConversations();
    } catch (e) {
      SdLogV5.e('Chat', 'reply to $conversationId failed: $e');
    }
  }

  @override
  Future<Either<Failure, Unit>> markRead(String conversationId) async {
    try {
      await dataSource.markRead(conversationId);
      await _pushConversations();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> reset() async {
    try {
      await dataSource.reset();
      // The inbox and badge show the first-launch threads again.
      unawaited(_pushConversations());
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
