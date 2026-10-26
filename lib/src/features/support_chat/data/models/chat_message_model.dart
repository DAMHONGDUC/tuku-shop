class ChatMessageModel {
  final String? id;
  final String? text;

  /// `customer` or `agent`.
  final String? sender;
  final String? sentAt;
  final String? agentName;

  const ChatMessageModel({
    this.id,
    this.text,
    this.sender,
    this.sentAt,
    this.agentName,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String?,
      text: json['text'] as String?,
      sender: json['sender'] as String?,
      sentAt: json['sentAt'] as String?,
      agentName: json['agentName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'sender': sender,
    'sentAt': sentAt,
    'agentName': agentName,
  };
}
