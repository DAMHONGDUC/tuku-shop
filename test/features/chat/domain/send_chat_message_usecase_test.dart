import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';

class _Repo extends Mock implements ChatRepository {}

void main() {
  test('blank or too-long messages never reach the API', () async {
    final repo = _Repo();
    final usecase = SendChatMessageUsecase(repo);
    for (final text in ['  ', 'x' * (SendChatMessageUsecase.maxLength + 1)]) {
      expect(
        await usecase.call(SendChatParams(conversationId: 'c', text: text)),
        const Left(ValidationFailure('invalid_message')),
      );
    }
    verifyZeroInteractions(repo);
  });

  test('text is trimmed before sending', () async {
    final repo = _Repo();
    final sent = ChatMessage(
      id: 'c-2',
      conversationId: 'c',
      text: 'hi',
      sender: ChatSender.customer,
      sentAt: DateTime.utc(2026),
    );
    when(() => repo.send('c', 'hi')).thenAnswer((_) async => Right(sent));
    expect(
      await SendChatMessageUsecase(
        repo,
      ).call(const SendChatParams(conversationId: 'c', text: '  hi ')),
      Right(sent),
    );
  });
}
