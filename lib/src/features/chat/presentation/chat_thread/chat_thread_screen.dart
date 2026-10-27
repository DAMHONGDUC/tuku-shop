import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import '../widgets/chat_peer_avatar.dart';
import 'chat_thread_controller.dart';
import 'components/chat_bubble.dart';
import 'components/chat_composer.dart';
import 'components/typing_bubble.dart';

/// One thread with a shop or Tuku Care: messages, quick questions that fit
/// who you talk to, and a composer.
class ChatThreadScreen extends StatelessWidget {
  const ChatThreadScreen({super.key, required this.peerId});

  /// A seller id, or [ChatRoutes.supportPeerId].
  final String peerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatThreadController>()..open(peerId),
      child: _View(peerId: peerId),
    );
  }
}

class _View extends StatelessWidget {
  const _View({required this.peerId});

  final String peerId;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return BlocConsumer<ChatThreadController, ChatThreadState>(
      listenWhen: (a, b) => b.failureCount > a.failureCount,
      listener: (context, _) => AppToast.of(
        context,
      ).show(loc.support_send_failed, type: AppToastType.error),
      builder: (context, state) {
        final controller = context.read<ChatThreadController>();
        final support = peerId == ChatRoutes.supportPeerId;
        final quick = support
            ? [
                loc.support_quick_order,
                loc.support_quick_return,
                loc.support_quick_voucher,
              ]
            : [
                loc.chat_quick_stock,
                loc.chat_quick_size,
                loc.chat_quick_ship,
                loc.chat_quick_discount,
              ];

        return SdKeyboardDismisserV5(
          child: Scaffold(
            backgroundColor: colors.pageDefault,
            appBar: AppTopBar(
              centerTitle: false,
              titleWidget: _Header(state: state, support: support),
            ),
            body: Column(
              children: [
                Expanded(
                  child: switch (state.status) {
                    ChatThreadStatus.loading => const _Skeleton(),
                    ChatThreadStatus.error => Padding(
                      padding: EdgeInsets.all(SdSpacingV5.s16),
                      child: SectionError(
                        onRetry: () => controller.open(peerId),
                      ),
                    ),
                    ChatThreadStatus.loaded => _Messages(state: state),
                  },
                ),
                ChatComposer(
                  quickQuestions: quick,
                  enabled: state.status == ChatThreadStatus.loaded,
                  isSending: state.isSending,
                  onSend: controller.send,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Who you talk to; a shop's header opens its listings.
class _Header extends StatelessWidget {
  const _Header({required this.state, required this.support});

  final ChatThreadState state;
  final bool support;

  static String _compact(int n) => AppFormat.compactCount(n);

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;
    final seller = state.seller;
    final name = support ? loc.chat_support_name : seller?.name ?? '';
    final subtitle = support
        ? loc.support_subtitle
        : seller == null
        ? ''
        : loc.chat_seller_stats(
            seller.rating.toStringAsFixed(1),
            seller.responseRate,
            _compact(seller.followerCount),
          );

    final header = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ChatPeerAvatar(seller: support ? null : seller, size: SdSpacingV5.s36),
        SdHorizontalSpacingV5(value: SdSpacingV5.s8),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: SdTextStyleV5.heading16()
                    .wColor(colors.textDefault)
                    .wDisplay(),
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: SdTextStyleV5.body10().wColor(colors.textSubTitle),
              ),
            ],
          ),
        ),
      ],
    );

    if (support || seller == null) return header;
    return Semantics(
      button: true,
      label: loc.pdp_view_shop,
      child: GestureDetector(
        onTap: () => context.push(ShopRoutes.shopLocation(seller.id)),
        child: header,
      ),
    );
  }
}

/// Newest at the bottom; the list starts there and grows upward.
class _Messages extends StatelessWidget {
  const _Messages({required this.state});

  final ChatThreadState state;

  @override
  Widget build(BuildContext context) {
    final messages = state.messages.reversed.toList();
    final extra = state.peerTyping ? 1 : 0;

    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.fromLTRB(
        SdSpacingV5.s16,
        SdSpacingV5.s16,
        SdSpacingV5.s16,
        SdSpacingV5.s8,
      ),
      itemCount: messages.length + extra,
      itemBuilder: (context, index) {
        if (index < extra) return const TypingBubble();
        final message = messages[index - extra];
        // Spacing tightens between consecutive messages from one side.
        final older = index - extra + 1 < messages.length
            ? messages[index - extra + 1]
            : null;
        final sameSide = older != null && older.sender == message.sender;
        return Padding(
          padding: EdgeInsets.only(
            top: sameSide ? SdSpacingV5.s4 : SdSpacingV5.s12,
          ),
          child: ChatBubble(message: message),
        );
      },
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  /// Bubble widths, varied like a real conversation.
  static const _widths = [0.7, 0.5, 0.8, 0.45, 0.6];

  @override
  Widget build(BuildContext context) {
    // Five bubbles from the top, all on the start side.
    return ListView(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      children: [
        for (final w in _widths) ...[
          FractionallySizedBox(
            alignment: AlignmentDirectional.centerStart,
            widthFactor: w,
            child: const SkeletonBox(
              height: SdSpacingV5.s44,
              radius: SdSpacingV5.s16,
            ),
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s12),
        ],
      ],
    );
  }
}
