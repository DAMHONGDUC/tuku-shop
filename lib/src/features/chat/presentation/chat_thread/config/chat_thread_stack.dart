import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../chat_thread_screen.dart';

/// One thread, above the tabs.
class ChatThreadStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: ChatRoutes.thread.path,
      name: ChatRoutes.thread.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return ChatThreadScreen(
          peerId: state.uri.queryParameters['peer'] ?? ChatRoutes.supportPeerId,
        );
      },
    ),
  ];
}
