class ConversationModel {
  final String? id;
  final String? peerId;

  /// `support` or `seller`.
  final String? peerType;
  final String? lastMessage;
  final String? updatedAt;
  final int? unreadCount;

  const ConversationModel({
    this.id,
    this.peerId,
    this.peerType,
    this.lastMessage,
    this.updatedAt,
    this.unreadCount,
  });

  ConversationModel copyWith({
    String? lastMessage,
    String? updatedAt,
    int? unreadCount,
  }) {
    return ConversationModel(
      id: id,
      peerId: peerId,
      peerType: peerType,
      lastMessage: lastMessage ?? this.lastMessage,
      updatedAt: updatedAt ?? this.updatedAt,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String?,
      peerId: json['peerId'] as String?,
      peerType: json['peerType'] as String?,
      lastMessage: json['lastMessage'] as String?,
      updatedAt: json['updatedAt'] as String?,
      unreadCount: json['unreadCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'peerId': peerId,
    'peerType': peerType,
    'lastMessage': lastMessage,
    'updatedAt': updatedAt,
    'unreadCount': unreadCount,
  };
}

class ChatMessageModel {
  final String? id;
  final String? conversationId;
  final String? text;

  /// `customer` or `peer`.
  final String? sender;
  final String? sentAt;

  const ChatMessageModel({
    this.id,
    this.conversationId,
    this.text,
    this.sender,
    this.sentAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String?,
      conversationId: json['conversationId'] as String?,
      text: json['text'] as String?,
      sender: json['sender'] as String?,
      sentAt: json['sentAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversationId': conversationId,
    'text': text,
    'sender': sender,
    'sentAt': sentAt,
  };
}
