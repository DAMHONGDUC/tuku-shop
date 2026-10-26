import 'package:tuku_shop/src/features/chat/data/models/chat_models.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';

class ConversationModelToConversationMapper {
  const ConversationModelToConversationMapper._();

  static Conversation toEntity(ConversationModel model) {
    return Conversation(
      id: model.id ?? '',
      peerId: model.peerId ?? '',
      peerType: model.peerType == 'support'
          ? ChatPeerType.support
          : ChatPeerType.seller,
      lastMessage: model.lastMessage ?? '',
      updatedAt: DateTime.tryParse(model.updatedAt ?? '') ?? DateTime(2026),
      unreadCount: model.unreadCount ?? 0,
    );
  }
}

class ChatMessageModelToChatMessageMapper {
  const ChatMessageModelToChatMessageMapper._();

  static ChatMessage toEntity(ChatMessageModel model) {
    return ChatMessage(
      id: model.id ?? '',
      conversationId: model.conversationId ?? '',
      text: model.text ?? '',
      sender: model.sender == 'customer'
          ? ChatSender.customer
          : ChatSender.peer,
      sentAt: DateTime.tryParse(model.sentAt ?? '') ?? DateTime(2026),
    );
  }
}
