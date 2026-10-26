import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../chat_list_screen.dart';

/// The Chat tab.
class ChatListStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: ChatRoutes.chats.path,
      name: ChatRoutes.chats.name,
      builder: (BuildContext context, GoRouterState state) {
        return const ChatListScreen();
      },
    ),
  ];
}
