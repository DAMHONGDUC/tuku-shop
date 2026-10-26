import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_badge/chat_unread_controller.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_list/chat_list_controller.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_thread/chat_thread_controller.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

class _GetConversations extends Mock implements GetConversationsUsecase {}

class _WatchConversations extends Mock implements WatchConversationsUsecase {}

class _GetSellers extends Mock implements GetSellersByIdsUsecase {}

class _GetSeller extends Mock implements GetSellerUsecase {}

class _Open extends Mock implements OpenConversationUsecase {}

class _GetMessages extends Mock implements GetChatMessagesUsecase {}

class _WatchMessages extends Mock implements WatchChatMessagesUsecase {}

class _Send extends Mock implements SendChatMessageUsecase {}

class _MarkRead extends Mock implements MarkConversationReadUsecase {}

void main() {
  final at = DateTime.utc(2026, 10, 27);
  Conversation conversation(
    String peerId, {
    int minutesAgo = 0,
    int unread = 0,
  }) => Conversation(
    id: 'c-$peerId',
    peerId: peerId,
    peerType: peerId == 'tuku-care'
        ? ChatPeerType.support
        : ChatPeerType.seller,
    lastMessage: 'last',
    updatedAt: at.subtract(Duration(minutes: minutesAgo)),
    unreadCount: unread,
  );
  const aurora = Seller(
    id: 'aurora-official',
    name: 'Aurora Official Store',
    colorHex: '#B5487A',
    rating: 4.9,
    followerCount: 100,
    responseRate: 99,
    location: 'HCMC',
    isOfficial: true,
  );

  late _GetConversations getConversations;
  late _WatchConversations watchConversations;
  late StreamController<List<Conversation>> inbox;

  setUpAll(() {
    registerFallbackValue(const SendChatParams(conversationId: '', text: ''));
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    getConversations = _GetConversations();
    watchConversations = _WatchConversations();
    inbox = StreamController.broadcast();
    when(() => watchConversations()).thenAnswer((_) => inbox.stream);
  });

  tearDown(() => inbox.close());

  group('ChatUnreadController', () {
    blocTest<ChatUnreadController, int>(
      'sums unread messages and follows changes',
      setUp: () => when(() => getConversations.call(NoParams())).thenAnswer(
        (_) async => Right([
          conversation('aurora-official', unread: 2),
          conversation('tuku-care', unread: 1),
        ]),
      ),
      build: () => ChatUnreadController(getConversations, watchConversations),
      act: (c) async {
        await c.load();
        inbox.add([conversation('aurora-official')]);
      },
      expect: () => [3, 0],
    );
  });

  group('ChatListController', () {
    late _GetSellers getSellers;

    setUp(() {
      getSellers = _GetSellers();
      when(
        () => getSellers.call(any()),
      ).thenAnswer((_) async => const Right([aurora]));
    });

    blocTest<ChatListController, ChatListState>(
      'pins support first and attaches each shop',
      setUp: () => when(() => getConversations.call(NoParams())).thenAnswer(
        (_) async => Right([
          conversation('aurora-official', minutesAgo: 1),
          conversation('tuku-care', minutesAgo: 60),
        ]),
      ),
      build: () =>
          ChatListController(getConversations, watchConversations, getSellers),
      act: (c) => c.load(),
      verify: (c) {
        expect(c.state.status, ChatListStatus.loaded);
        expect(c.state.conversations.map((e) => e.peerId), [
          'tuku-care',
          'aurora-official',
        ]);
        expect(c.state.sellers['aurora-official'], aurora);
        verify(() => getSellers.call(['aurora-official'])).called(1);
      },
    );
  });

  group('ChatThreadController', () {
    late _Open open;
    late _GetMessages getMessages;
    late _WatchMessages watchMessages;
    late _Send send;
    late _MarkRead markRead;
    late _GetSeller getSeller;
    late StreamController<ChatThreadUpdate> pushes;

    final thread = conversation('aurora-official', unread: 1);
    final greeting = ChatMessage(
      id: '1',
      conversationId: thread.id,
      text: 'Hi',
      sender: ChatSender.peer,
      sentAt: at,
    );
    final mine = ChatMessage(
      id: '2',
      conversationId: thread.id,
      text: 'Is this in stock?',
      sender: ChatSender.customer,
      sentAt: at,
    );
    final answer = ChatMessage(
      id: '3',
      conversationId: thread.id,
      text: 'Yes',
      sender: ChatSender.peer,
      sentAt: at,
    );

    setUp(() {
      open = _Open();
      getMessages = _GetMessages();
      watchMessages = _WatchMessages();
      send = _Send();
      markRead = _MarkRead();
      getSeller = _GetSeller();
      pushes = StreamController.broadcast();
      when(() => watchMessages()).thenAnswer((_) => pushes.stream);
      when(
        () => open.call('aurora-official'),
      ).thenAnswer((_) async => Right(thread));
      when(
        () => getMessages.call(thread.id),
      ).thenAnswer((_) async => Right([greeting]));
      when(
        () => getSeller.call('aurora-official'),
      ).thenAnswer((_) async => const Right(aurora));
      when(
        () => markRead.call(any()),
      ).thenAnswer((_) async => const Right(unit));
    });

    tearDown(() => pushes.close());

    ChatThreadController build() => ChatThreadController(
      open,
      getMessages,
      watchMessages,
      send,
      markRead,
      getSeller,
    );

    test(
      'open loads messages and the shop, and marks the thread read',
      () async {
        final c = build();
        await c.open('aurora-official');
        expect(c.state.status, ChatThreadStatus.loaded);
        expect(c.state.messages, [greeting]);
        expect(c.state.seller, aurora);
        verify(() => markRead.call(thread.id)).called(1);
        await c.close();
      },
    );

    test('send shows the message, typing, then the pushed answer', () async {
      when(() => send.call(any())).thenAnswer((_) async => Right(mine));
      final c = build();
      await c.open('aurora-official');

      expect(await c.send(mine.text), isTrue);
      expect(c.state.messages, [greeting, mine]);
      expect(c.state.peerTyping, isTrue);

      pushes.add((
        conversationId: thread.id,
        messages: [greeting, mine, answer],
      ));
      await Future<void>.delayed(Duration.zero);
      expect(c.state.messages.last, answer);
      expect(c.state.peerTyping, isFalse);
      await c.close();
    });

    test('answers for another thread are ignored', () async {
      final c = build();
      await c.open('aurora-official');
      pushes.add((conversationId: 'c-other', messages: [answer]));
      await Future<void>.delayed(Duration.zero);
      expect(c.state.messages, [greeting]);
      await c.close();
    });
  });
}
