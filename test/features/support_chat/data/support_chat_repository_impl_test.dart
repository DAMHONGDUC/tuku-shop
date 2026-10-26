import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/support_chat/data/data_sources/support_chat_local_data_source.dart';
import 'package:tuku_shop/src/features/support_chat/data/mock/support_chat_mock.dart';
import 'package:tuku_shop/src/features/support_chat/data/repositories/support_chat_repository_impl.dart';
import 'package:tuku_shop/src/features/support_chat/domain/domain.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  SupportChatRepositoryImpl build() => SupportChatRepositoryImpl(
    dataSource: SupportChatLocalDataSourceImpl(
      clock: () => DateTime.utc(2026, 10, 27, 9, 30),
    ),
  );

  test('first launch opens with the agent greeting', () {
    fakeAsync((async) {
      late List<ChatMessage> messages;
      build().getMessages().then((r) => messages = r.getOrElse(() => []));
      async.elapse(MockLatency.max);
      expect(messages.single.sender, ChatSender.agent);
      expect(messages.single.text, SupportChatMock.greeting);
    });
  });

  test('a sent message is stored and the agent answers on the stream', () {
    fakeAsync((async) {
      final repo = build();
      final pushed = <List<ChatMessage>>[];
      repo.watchMessages().listen(pushed.add);

      ChatMessage? sent;
      repo
          .send('Where is my order?')
          .then((r) => sent = r.toOption().toNullable());
      async.elapse(MockLatency.max);
      expect(sent!.isMine, isTrue);
      expect(pushed, isEmpty);

      async.elapse(MockLatency.max * 3);
      final last = pushed.single;
      expect(last.map((m) => m.sender), [
        ChatSender.agent,
        ChatSender.customer,
        ChatSender.agent,
      ]);
      expect(last.last.text, contains('My orders'));
    });
  });

  test('the conversation survives a relaunch until reset', () {
    fakeAsync((async) {
      build().send('thanks');
      async.elapse(MockLatency.max * 4);

      late List<ChatMessage> again;
      build().getMessages().then((r) => again = r.getOrElse(() => []));
      async.elapse(MockLatency.max);
      expect(again.length, 3);

      build().reset();
      async.flushMicrotasks();
      build().getMessages().then((r) => again = r.getOrElse(() => []));
      async.elapse(MockLatency.max);
      expect(again.length, 1);
    });
  });

  test('answers match English and Vietnamese keywords', () {
    expect(SupportChatMock.answerTo('Đổi hoặc trả hàng'), contains('30 days'));
    expect(SupportChatMock.answerTo('any VOUCHERS?'), contains('TUKU10'));
    expect(SupportChatMock.answerTo('hello there'), contains('teammate'));
  });
}
