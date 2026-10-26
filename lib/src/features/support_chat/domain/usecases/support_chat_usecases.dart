import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/support_chat/domain/entities/chat_message.dart';
import 'package:tuku_shop/src/features/support_chat/domain/repositories/support_chat_repository.dart';

class GetSupportMessagesUsecase
    implements UseCase<List<ChatMessage>, NoParams> {
  final SupportChatRepository repository;

  GetSupportMessagesUsecase(this.repository);

  @override
  Future<Either<Failure, List<ChatMessage>>> call(NoParams params) =>
      repository.getMessages();
}

class SendSupportMessageUsecase implements UseCase<ChatMessage, String> {
  final SupportChatRepository repository;

  SendSupportMessageUsecase(this.repository);

  /// Longest message the support desk accepts.
  static const maxLength = 1000;

  @override
  Future<Either<Failure, ChatMessage>> call(String params) {
    final text = params.trim();
    if (text.isEmpty || text.length > maxLength) {
      return Future.value(const Left(ValidationFailure('invalid_message')));
    }
    return repository.send(text);
  }
}

/// A stream, not an `Either`: agent answers arrive whenever they are ready.
class WatchSupportMessagesUsecase {
  final SupportChatRepository repository;

  WatchSupportMessagesUsecase(this.repository);

  Stream<List<ChatMessage>> call() => repository.watchMessages();
}

class ResetSupportChatUsecase implements UseCase<Unit, NoParams> {
  final SupportChatRepository repository;

  ResetSupportChatUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.reset();
}
