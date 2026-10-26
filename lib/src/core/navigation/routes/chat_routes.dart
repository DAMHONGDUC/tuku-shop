import 'package:system_design/index.dart';

/// The Chat tab and one thread, which any feature can open by peer id: a
/// seller id, or [supportPeerId] for the marketplace's own support desk.
class ChatRoutes {
  static const SdRouterV5 chats = SdRouterV5(
    name: 'chats',
    path: '/chats',
    fullPath: '/chats',
  );

  static const SdRouterV5 thread = SdRouterV5(
    name: 'chat-thread',
    path: '/chat',
    fullPath: '/chat',
  );

  /// The support desk's peer id (matches the chat feature's).
  static const supportPeerId = 'tuku-care';

  static String threadLocation(String peerId) =>
      Uri(path: thread.fullPath, queryParameters: {'peer': peerId}).toString();

  static String supportLocation() => threadLocation(supportPeerId);
}
