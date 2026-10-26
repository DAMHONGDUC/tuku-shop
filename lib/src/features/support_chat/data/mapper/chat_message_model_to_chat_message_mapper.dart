import 'package:tuku_shop/src/features/support_chat/data/models/chat_message_model.dart';
import 'package:tuku_shop/src/features/support_chat/domain/entities/chat_message.dart';

class ChatMessageModelToChatMessageMapper {
  const ChatMessageModelToChatMessageMapper._();

  static ChatMessage toEntity(ChatMessageModel model) {
    return ChatMessage(
      id: model.id ?? '',
      text: model.text ?? '',
      sender: model.sender == 'agent' ? ChatSender.agent : ChatSender.customer,
      sentAt: DateTime.tryParse(model.sentAt ?? '') ?? DateTime(2026),
      agentName: model.agentName ?? '',
    );
  }
}
