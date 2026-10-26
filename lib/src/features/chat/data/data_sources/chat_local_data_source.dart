import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/data/mock/chat_mock.dart';
import 'package:tuku_shop/src/features/chat/data/models/chat_models.dart';

/// Stand-in for the chat API: keeps every thread on the device and answers
/// as the support desk or the shop.
abstract class ChatLocalDataSource {
  Future<List<ConversationModel>> getConversations();

  /// The thread with [peerId], created when missing (with a greeting).
  Future<ConversationModel> openConversation(String peerId);

  Future<List<ChatMessageModel>> getMessages(String conversationId);

  /// Stores the customer's [text]; returns it as sent.
  Future<ChatMessageModel> send(String conversationId, String text);

  /// Waits for, stores and returns the other side's answer to [text].
  Future<ChatMessageModel> awaitReply(String conversationId, String text);

  Future<void> markRead(String conversationId);

  /// Back to the first-launch threads.
  Future<void> reset();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  ChatLocalDataSourceImpl({
    SharedPreferencesAsync? prefs,
    DateTime Function()? clock,
  }) : _prefs = prefs ?? SharedPreferencesAsync(),
       _now = clock ?? DateTime.now;

  static const kStoreKey = 'chat_store';

  final SharedPreferencesAsync _prefs;
  final DateTime Function() _now;

  Future<(List<ConversationModel>, Map<String, List<ChatMessageModel>>)>
  _read() async {
    final raw = await _prefs.getString(kStoreKey);
    if (raw == null) {
      final seed = ChatMock.seed(_now());
      await _write(seed.$1, seed.$2);
      return seed;
    }
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return (
      [
        for (final c in json['conversations'] as List)
          ConversationModel.fromJson(c as Map<String, dynamic>),
      ],
      {
        for (final e in (json['messages'] as Map<String, dynamic>).entries)
          e.key: [
            for (final m in e.value as List)
              ChatMessageModel.fromJson(m as Map<String, dynamic>),
          ],
      },
    );
  }

  Future<void> _write(
    List<ConversationModel> conversations,
    Map<String, List<ChatMessageModel>> messages,
  ) {
    return _prefs.setString(
      kStoreKey,
      jsonEncode({
        'conversations': [for (final c in conversations) c.toJson()],
        'messages': {
          for (final e in messages.entries)
            e.key: [for (final m in e.value) m.toJson()],
        },
      }),
    );
  }

  /// Adds a message to [conversationId] and moves the thread to the top.
  Future<ChatMessageModel> _append(
    String conversationId,
    String sender,
    String text,
  ) async {
    final (conversations, messages) = await _read();
    final thread = messages[conversationId] ?? [];
    final at = _now().toIso8601String();
    final message = ChatMessageModel(
      id: '$conversationId-${thread.length + 1}',
      conversationId: conversationId,
      text: text,
      sender: sender,
      sentAt: at,
    );
    messages[conversationId] = [...thread, message];
    final updated = [
      for (final c in conversations)
        if (c.id == conversationId)
          c.copyWith(
            lastMessage: text,
            updatedAt: at,
            unreadCount: sender == 'peer' ? (c.unreadCount ?? 0) + 1 : 0,
          )
        else
          c,
    ];
    await _write(updated, messages);
    return message;
  }

  Future<T> _guard<T>(Future<T> Function() run) async {
    try {
      await MockLatency.wait();
      return await run();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<List<ConversationModel>> getConversations() =>
      _guard(() async => (await _read()).$1);

  @override
  Future<ConversationModel> openConversation(String peerId) => _guard(() async {
    final (conversations, messages) = await _read();
    final existing = conversations.firstWhereOrNull((c) => c.peerId == peerId);
    if (existing != null) return existing;

    final support = peerId == ChatMock.supportPeerId;
    final id = 'c-$peerId';
    final greeting = support ? ChatMock.supportGreeting : ChatMock.shopGreeting;
    final at = _now().toIso8601String();
    final created = ConversationModel(
      id: id,
      peerId: peerId,
      peerType: support ? 'support' : 'seller',
      lastMessage: greeting,
      updatedAt: at,
      unreadCount: 0,
    );
    messages[id] = [
      ChatMessageModel(
        id: '$id-1',
        conversationId: id,
        text: greeting,
        sender: 'peer',
        sentAt: at,
      ),
    ];
    await _write([created, ...conversations], messages);
    return created;
  });

  @override
  Future<List<ChatMessageModel>> getMessages(String conversationId) =>
      _guard(() async => (await _read()).$2[conversationId] ?? const []);

  @override
  Future<ChatMessageModel> send(String conversationId, String text) =>
      _guard(() => _append(conversationId, 'customer', text));

  @override
  Future<ChatMessageModel> awaitReply(String conversationId, String text) =>
      _guard(() async {
        final (conversations, _) = await _read();
        final thread = conversations.firstWhereOrNull(
          (c) => c.id == conversationId,
        );
        return _append(
          conversationId,
          'peer',
          ChatMock.answerTo(text, fromSupport: thread?.peerType == 'support'),
        );
      });

  @override
  Future<void> markRead(String conversationId) => _guard(() async {
    final (conversations, messages) = await _read();
    await _write([
      for (final c in conversations)
        c.id == conversationId ? c.copyWith(unreadCount: 0) : c,
    ], messages);
  });

  @override
  Future<void> reset() async {
    try {
      await _prefs.remove(kStoreKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
