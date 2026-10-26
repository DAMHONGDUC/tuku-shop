import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../support_chat_screen.dart';

class SupportChatStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: SupportChatRoutes.chat.path,
      name: SupportChatRoutes.chat.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const SupportChatScreen();
      },
    ),
  ];
}
