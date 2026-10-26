import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/support_chat/domain/domain.dart';
import 'package:tuku_shop/src/features/support_chat/presentation/support_chat/support_chat_controller.dart';

class _Get extends Mock implements GetSupportMessagesUsecase {}

class _Send extends Mock implements SendSupportMessageUsecase {}

class _Watch extends Mock implements WatchSupportMessagesUsecase {}

void main() {
  late _Get get;
  late _Send send;
  late _Watch watch;
  late StreamController<List<ChatMessage>> pushes;

  final greeting = ChatMessage(
    id: 'm1',
    text: 'Hi',
    sender: ChatSender.agent,
    sentAt: DateTime.utc(2026),
  );
  final mine = ChatMessage(
    id: 'm2',
    text: 'Where is my order?',
    sender: ChatSender.customer,
    sentAt: DateTime.utc(2026),
  );
  final answer = ChatMessage(
    id: 'm3',
    text: 'Check My orders',
    sender: ChatSender.agent,
    sentAt: DateTime.utc(2026),
  );
  final loaded = SupportChatState(
    status: SupportChatStatus.loaded,
    messages: [greeting],
  );

  setUp(() {
    get = _Get();
    send = _Send();
    watch = _Watch();
    pushes = StreamController.broadcast();
    when(() => watch()).thenAnswer((_) => pushes.stream);
    when(() => get.call(NoParams())).thenAnswer((_) async => Right([greeting]));
  });

  tearDown(() => pushes.close());

  SupportChatController build() => SupportChatController(get, send, watch);

  blocTest<SupportChatController, SupportChatState>(
    'load shows the conversation',
    build: build,
    act: (c) => c.load(),
    expect: () => [const SupportChatState(), loaded],
  );

  blocTest<SupportChatController, SupportChatState>(
    'send shows the message, then typing until the answer is pushed',
    build: build,
    seed: () => loaded,
    setUp: () =>
        when(() => send.call(mine.text)).thenAnswer((_) async => Right(mine)),
    act: (c) async {
      await c.send(mine.text);
      pushes.add([greeting, mine, answer]);
    },
    expect: () => [
      loaded.copyWith(isSending: true),
      loaded.copyWith(agentTyping: true, messages: [greeting, mine]),
      loaded.copyWith(messages: [greeting, mine, answer]),
    ],
  );

  blocTest<SupportChatController, SupportChatState>(
    'a failed send keeps the conversation and counts the failure',
    build: build,
    seed: () => loaded,
    setUp: () => when(
      () => send.call(any()),
    ).thenAnswer((_) async => Left(CacheFailure())),
    act: (c) => c.send('hello'),
    expect: () => [
      loaded.copyWith(isSending: true),
      loaded.copyWith(failureCount: 1),
    ],
  );
}
