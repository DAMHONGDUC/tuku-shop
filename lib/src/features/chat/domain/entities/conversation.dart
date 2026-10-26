import 'package:equatable/equatable.dart';

/// Who the customer talks to: the marketplace's own support desk, or a shop.
enum ChatPeerType { support, seller }

/// One chat thread, as the inbox lists it.
class Conversation extends Equatable {
  final String id;

  /// [supportPeerId] for the support desk, otherwise a seller id.
  final String peerId;
  final ChatPeerType peerType;
  final String lastMessage;
  final DateTime updatedAt;
  final int unreadCount;

  /// The support desk's peer id.
  static const supportPeerId = 'tuku-care';

  const Conversation({
    required this.id,
    required this.peerId,
    required this.peerType,
    required this.lastMessage,
    required this.updatedAt,
    this.unreadCount = 0,
  });

  bool get isSupport => peerType == ChatPeerType.support;

  @override
  List<Object?> get props => [
    id,
    peerId,
    peerType,
    lastMessage,
    updatedAt,
    unreadCount,
  ];
}
