import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

import '../widgets/chat_peer_avatar.dart';
import 'chat_list_controller.dart';

/// The Chat tab: one thread per shop plus Tuku Care, newest first.
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatListController>()..load(),
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

    return Scaffold(
      backgroundColor: colors.pageDefault,
      appBar: AppTopBar(title: loc.chat_title, large: true),
      body: BlocBuilder<ChatListController, ChatListState>(
        builder: (context, state) {
          final controller = context.read<ChatListController>();
          return RefreshWrapper(
            onRefresh: controller.load,
            child: switch (state.status) {
              ChatListStatus.loading => ListView(
                padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
                children: const [
                  ListSkeleton(
                    leading: ListSkeletonLeading.avatar,
                    divided: true,
                  ),
                ],
              ),
              ChatListStatus.error => ListView(
                padding: EdgeInsets.all(SdSpacingV5.s16),
                children: [SectionError(onRetry: controller.load)],
              ),
              ChatListStatus.loaded when state.conversations.isEmpty =>
                ListView(
                  padding: EdgeInsets.all(SdSpacingV5.s16),
                  children: [
                    EmptyState(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: loc.chat_empty_title,
                      message: loc.chat_empty_message,
                    ),
                  ],
                ),
              ChatListStatus.loaded => ListView.separated(
                padding: EdgeInsets.only(
                  top: SdSpacingV5.s4,
                  bottom: FloatingBottomNav.contentInset(context),
                ),
                itemCount: state.conversations.length,
                separatorBuilder: (_, _) => Divider(
                  height: 1,
                  indent: SdSpacingV5.s16 + SdSpacingV5.s48 + SdSpacingV5.s12,
                  color: colors.borderDefault,
                ),
                itemBuilder: (context, i) {
                  final conversation = state.conversations[i];
                  return _ConversationRow(
                    conversation: conversation,
                    seller: state.sellers[conversation.peerId],
                  );
                },
              ),
            },
          );
        },
      ),
    );
  }
}

class _ConversationRow extends StatelessWidget {
  const _ConversationRow({required this.conversation, this.seller});

  final Conversation conversation;
  final Seller? seller;

  static String _when(BuildContext context, DateTime at) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(at.year, at.month, at.day);
    if (day == today) {
      return '${at.hour.toString().padLeft(2, '0')}:'
          '${at.minute.toString().padLeft(2, '0')}';
    }
    if (today.difference(day).inDays == 1) return context.loc.chat_yesterday;
    return '${at.day.toString().padLeft(2, '0')}/'
        '${at.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;
    final unread = conversation.unreadCount > 0;
    final name = conversation.isSupport
        ? loc.chat_support_name
        : seller?.name ?? '';
    final official = !conversation.isSupport && (seller?.isOfficial ?? false);

    return InkWell(
      onTap: () => context.push(ChatRoutes.threadLocation(conversation.peerId)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SdSpacingV5.s16,
          vertical: SdSpacingV5.s12,
        ),
        child: Row(
          children: [
            ChatPeerAvatar(seller: conversation.isSupport ? null : seller),
            SdHorizontalSpacingV5(value: SdSpacingV5.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // The name takes what the time leaves; an official
                      // shop's check and the support tag stay compact.
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: SdTextStyleV5.body14()
                                    .wSemiBold()
                                    .wColor(colors.textDefault),
                              ),
                            ),
                            if (official) ...[
                              SdHorizontalSpacingV5(value: SdSpacingV5.s4),
                              Semantics(
                                label: loc.chat_official,
                                child: SdIconV5(
                                  iconData: Icons.verified_rounded,
                                  iconSize: SdSpacingV5.s16,
                                  color: colors.primary,
                                ),
                              ),
                            ],
                            if (conversation.isSupport) ...[
                              SdHorizontalSpacingV5(value: SdSpacingV5.s6),
                              TagChip(
                                label: loc.chat_support_tag,
                                color: colors.primary,
                              ),
                            ],
                          ],
                        ),
                      ),
                      SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                      Text(
                        _when(context, conversation.updatedAt),
                        style: SdTextStyleV5.body12().wColor(
                          unread ? colors.primary : colors.textSubTitle,
                        ),
                      ),
                    ],
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              (unread
                                      ? SdTextStyleV5.body14().wSemiBold()
                                      : SdTextStyleV5.body14())
                                  .wColor(
                                    unread
                                        ? colors.textDefault
                                        : colors.textSubTitle,
                                  ),
                        ),
                      ),
                      if (unread) ...[
                        SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                        SdBadgeV5(
                          count: conversation.unreadCount,
                          size: SdSpacingV5.s18,
                          badgeColor: colors.sale,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
