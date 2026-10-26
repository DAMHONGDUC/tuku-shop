import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import 'components/chat_bubble.dart';
import 'components/chat_composer.dart';
import 'components/typing_bubble.dart';
import 'support_chat_controller.dart';

/// Chat with customer support: the conversation, quick questions and a
/// composer. Opens from Profile and from an order.
class SupportChatScreen extends StatelessWidget {
  const SupportChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SupportChatController>()..load(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return BlocConsumer<SupportChatController, SupportChatState>(
      listenWhen: (a, b) => b.failureCount > a.failureCount,
      listener: (context, _) => AppToast.of(
        context,
      ).show(loc.support_send_failed, type: AppToastType.error),
      builder: (context, state) {
        final controller = context.read<SupportChatController>();

        return SdKeyboardDismisserV5(
          child: Scaffold(
            backgroundColor: colors.pageDefault,
            appBar: AppTopBar(titleWidget: const _Header()),
            body: Column(
              children: [
                Expanded(
                  child: switch (state.status) {
                    SupportChatStatus.loading => const _Skeleton(),
                    SupportChatStatus.error => Padding(
                      padding: EdgeInsets.all(SdSpacingV5.s16),
                      child: SectionError(onRetry: controller.load),
                    ),
                    SupportChatStatus.loaded => _Messages(state: state),
                  },
                ),
                ChatComposer(
                  enabled: state.status == SupportChatStatus.loaded,
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

/// The agent's avatar, the desk's name and its reply time.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: SdSpacingV5.s36,
          height: SdSpacingV5.s36,
          decoration: BoxDecoration(
            color: colors.primarySoft,
            shape: BoxShape.circle,
          ),
          child: SdIconV5(
            iconData: Icons.support_agent_rounded,
            iconSize: SdSpacingV5.s20,
            color: colors.primary,
          ),
        ),
        SdHorizontalSpacingV5(value: SdSpacingV5.s8),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.support_title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: SdTextStyleV5.heading16()
                    .wColor(colors.textDefault)
                    .wDisplay(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: SdSpacingV5.s6,
                    height: SdSpacingV5.s6,
                    decoration: BoxDecoration(
                      color: colors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SdHorizontalSpacingV5(value: SdSpacingV5.s4),
                  Flexible(
                    child: Text(
                      loc.support_subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: SdTextStyleV5.body10().wColor(colors.textSubTitle),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Newest at the bottom; the list starts there and grows upward.
class _Messages extends StatelessWidget {
  const _Messages({required this.state});

  final SupportChatState state;

  @override
  Widget build(BuildContext context) {
    final messages = state.messages.reversed.toList();
    final extra = state.agentTyping ? 1 : 0;

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
          child: ChatBubble(message: message, showName: !sameSide),
        );
      },
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse: true,
      padding: EdgeInsets.all(SdSpacingV5.s16),
      children: [
        for (var i = 0; i < 4; i++) ...[
          Align(
            alignment: i.isEven ? Alignment.centerLeft : Alignment.centerRight,
            child: SkeletonBox(
              width: i.isEven ? 240 : 180,
              height: SdSpacingV5.s48,
              radius: SdSpacingV5.s16,
            ),
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s12),
        ],
      ],
    );
  }
}
