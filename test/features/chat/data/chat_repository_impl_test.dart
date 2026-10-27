import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:tuku_shop/src/features/chat/data/mock/chat_mock.dart';
import 'package:tuku_shop/src/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  ChatRepositoryImpl build() => ChatRepositoryImpl(
    dataSource: ChatLocalDataSourceImpl(
      clock: () => DateTime.utc(2026, 10, 27, 9, 30),
    ),
  );

  T run<T>(FakeAsync async, Future<T> future, {int waits = 1}) {
    late T result;
    future.then((value) => result = value);
    async.elapse(MockLatency.max * waits);
    return result;
  }

  test('first launch has support and three shop threads, newest first', () {
    fakeAsync((async) {
      final list = run(async, build().getConversations()).getOrElse(() => []);
      expect(list.length, 4);
      expect(list.where((c) => c.isSupport).length, 1);
      expect(list.first.peerId, 'aurora-official');
      expect(list.fold(0, (sum, c) => sum + c.unreadCount), 2);
    });
  });

  test('opening a new shop starts a thread with a greeting', () {
    fakeAsync((async) {
      final repo = build();
      final opened = run(
        async,
        repo.openConversation('denim-house'),
      ).getOrElse(() => throw 'Left');
      final messages = run(
        async,
        repo.getMessages(opened.id),
      ).getOrElse(() => []);
      expect(messages.single.text, ChatMock.shopGreeting);

      final again = run(
        async,
        repo.openConversation('denim-house'),
      ).getOrElse(() => throw 'Left');
      expect(again.id, opened.id);
      expect(run(async, repo.getConversations()).getOrElse(() => []).length, 5);
    });
  });

  test('a shop answers on the stream and the thread counts it unread', () {
    fakeAsync((async) {
      final repo = build();
      final updates = <ChatThreadUpdate>[];
      final inbox = <List<Conversation>>[];
      repo.watchMessages().listen(updates.add);
      repo.watchConversations().listen(inbox.add);

      run(async, repo.send('c-northline-official', 'Is this in stock?'));
      async.elapse(MockLatency.max * 4);

      final thread = updates.single;
      expect(thread.conversationId, 'c-northline-official');
      expect(thread.messages.last.sender, ChatSender.peer);
      expect(thread.messages.last.text, contains('in stock'));
      final northline = inbox.last.firstWhere(
        (c) => c.id == 'c-northline-official',
      );
      expect(northline.unreadCount, 1);
      expect(inbox.last.first.id, 'c-northline-official');
    });
  });

  test('markRead clears the count; reset restores the seed', () {
    fakeAsync((async) {
      final repo = build();
      run(async, repo.markRead('c-aurora-official'), waits: 2);
      var list = run(async, repo.getConversations()).getOrElse(() => []);
      expect(
        list.firstWhere((c) => c.peerId == 'aurora-official').unreadCount,
        0,
      );

      run(async, repo.reset());
      async.elapse(MockLatency.max);
      list = run(async, repo.getConversations()).getOrElse(() => []);
      expect(
        list.firstWhere((c) => c.peerId == 'aurora-official').unreadCount,
        1,
      );
    });
  });

  test('support and shops answer from their own scripts', () {
    expect(
      ChatMock.answerTo('đổi trả thế nào', fromSupport: true),
      contains('30 days'),
    );
    expect(
      ChatMock.answerTo('Còn hàng không?', fromSupport: false),
      contains('in stock'),
    );
    expect(
      ChatMock.answerTo('hello', fromSupport: false),
      contains('get back to you'),
    );
  });
}
