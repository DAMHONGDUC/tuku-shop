import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/support_chat/data/data_sources/support_chat_local_data_source.dart';
import 'package:tuku_shop/src/features/support_chat/data/mapper/chat_message_model_to_chat_message_mapper.dart';
import 'package:tuku_shop/src/features/support_chat/domain/domain.dart';

class SupportChatRepositoryImpl implements SupportChatRepository {
  SupportChatRepositoryImpl({required this.dataSource});

  final SupportChatLocalDataSource dataSource;
  final _changes = StreamController<List<ChatMessage>>.broadcast();

  @override
  Stream<List<ChatMessage>> watchMessages() => _changes.stream;

  @override
  Future<Either<Failure, List<ChatMessage>>> getMessages() async {
    try {
      final models = await dataSource.getMessages();
      return Right(
        models.map(ChatMessageModelToChatMessageMapper.toEntity).toList(),
      );
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ChatMessage>> send(String text) async {
    try {
      final sent = await dataSource.send(text);
      // The agent answers on its own time, like a push from the desk.
      unawaited(_deliverReply(text));
      return Right(ChatMessageModelToChatMessageMapper.toEntity(sent));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<void> _deliverReply(String text) async {
    try {
      await dataSource.awaitReply(text);
      final all = await dataSource.getMessages();
      _changes.add(
        all.map(ChatMessageModelToChatMessageMapper.toEntity).toList(),
      );
    } catch (e) {
      SdLogV5.e('SupportChat', 'agent reply failed: $e');
    }
  }

  @override
  Future<Either<Failure, Unit>> reset() async {
    try {
      await dataSource.reset();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
