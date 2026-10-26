import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/support_chat/domain/domain.dart';

class _Repo extends Mock implements SupportChatRepository {}

void main() {
  test('blank or too-long messages never reach the desk', () async {
    final repo = _Repo();
    final usecase = SendSupportMessageUsecase(repo);

    expect(
      await usecase.call('   '),
      const Left(ValidationFailure('invalid_message')),
    );
    expect(
      await usecase.call('x' * (SendSupportMessageUsecase.maxLength + 1)),
      const Left(ValidationFailure('invalid_message')),
    );
    verifyZeroInteractions(repo);
  });

  test('text is trimmed before sending', () async {
    final repo = _Repo();
    final sent = ChatMessage(
      id: 'm2',
      text: 'hi',
      sender: ChatSender.customer,
      sentAt: DateTime.utc(2026),
    );
    when(() => repo.send('hi')).thenAnswer((_) async => Right(sent));
    expect(await SendSupportMessageUsecase(repo).call('  hi  '), Right(sent));
  });
}
