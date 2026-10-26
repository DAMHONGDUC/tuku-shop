import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/support_chat/data/mock/support_chat_mock.dart';
import 'package:tuku_shop/src/features/support_chat/data/models/chat_message_model.dart';

/// Stand-in for the support desk API: stores the conversation on the device
/// and answers as the demo agent.
abstract class SupportChatLocalDataSource {
  Future<List<ChatMessageModel>> getMessages();

  /// Stores the customer's [text]; returns it as sent.
  Future<ChatMessageModel> send(String text);

  /// Waits for, stores and returns the agent's answer to [text].
  Future<ChatMessageModel> awaitReply(String text);

  /// Back to the first-launch greeting.
  Future<void> reset();
}

class SupportChatLocalDataSourceImpl implements SupportChatLocalDataSource {
  SupportChatLocalDataSourceImpl({
    SharedPreferencesAsync? prefs,
    DateTime Function()? clock,
  }) : _prefs = prefs ?? SharedPreferencesAsync(),
       _now = clock ?? DateTime.now;

  static const kMessagesKey = 'support_chat_messages';

  final SharedPreferencesAsync _prefs;
  final DateTime Function() _now;

  Future<List<ChatMessageModel>> _read() async {
    final raw = await _prefs.getString(kMessagesKey);
    if (raw != null) {
      return [
        for (final e in jsonDecode(raw) as List)
          ChatMessageModel.fromJson(e as Map<String, dynamic>),
      ];
    }
    final seed = [
      ChatMessageModel(
        id: 'm1',
        text: SupportChatMock.greeting,
        sender: 'agent',
        sentAt: _now().toIso8601String(),
        agentName: SupportChatMock.agentName,
      ),
    ];
    await _write(seed);
    return seed;
  }

  Future<void> _write(List<ChatMessageModel> messages) => _prefs.setString(
    kMessagesKey,
    jsonEncode([for (final m in messages) m.toJson()]),
  );

  Future<ChatMessageModel> _append(
    ChatMessageModel Function(int n) build,
  ) async {
    final messages = await _read();
    final message = build(messages.length + 1);
    await _write([...messages, message]);
    return message;
  }

  @override
  Future<List<ChatMessageModel>> getMessages() async {
    try {
      await MockLatency.wait();
      return await _read();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<ChatMessageModel> send(String text) async {
    try {
      await MockLatency.wait();
      return await _append(
        (n) => ChatMessageModel(
          id: 'm$n',
          text: text,
          sender: 'customer',
          sentAt: _now().toIso8601String(),
        ),
      );
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<ChatMessageModel> awaitReply(String text) async {
    try {
      await MockLatency.wait();
      return await _append(
        (n) => ChatMessageModel(
          id: 'm$n',
          text: SupportChatMock.answerTo(text),
          sender: 'agent',
          sentAt: _now().toIso8601String(),
          agentName: SupportChatMock.agentName,
        ),
      );
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> reset() async {
    try {
      await _prefs.remove(kMessagesKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
