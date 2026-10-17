import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

import 'components/notification_tile.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<NotificationsController>(
    create: (BuildContext _) => getIt<NotificationsController>()..load(),
    child: BlocBuilder<NotificationsController, NotificationsState>(
      builder: (BuildContext context, NotificationsState state) {
        final NotificationsController controller = context.read<NotificationsController>();
        final DateTime today = DateUtils.dateOnly(DateTime.now());
        final List<NotificationEntity> recent = state.items
            .where((NotificationEntity n) => !n.createdAt.isBefore(today))
            .toList();
        final List<NotificationEntity> earlier = state.items
            .where((NotificationEntity n) => n.createdAt.isBefore(today))
            .toList();

        void open(NotificationEntity n) {
          controller.markRead(n.id);
          if (n.link != null) context.push(n.link!);
        }

        return SdScaffoldV5(
          appBar: SdAppBarV5(
            title: context.loc.notifications_title,
            actions: <Widget>[
              if (state.hasUnread)
                SdButtonV5(
                  variant: SdButtonVariantV5.text,
                  size: SdButtonSizeV5.small,
                  label: context.loc.notifications_mark_all,
                  onPressed: controller.markAllRead,
                ),
            ],
          ),
          body: FadeSwitcher(
            child: switch (state.status) {
              LoadStatus.loading => const Center(child: SdLoadingV5()),
              LoadStatus.failure => ErrorView(onRetry: controller.load),
              LoadStatus.success when state.items.isEmpty => SdEmptyStateV5(
                icon: Symbols.notifications_off_rounded,
                title: context.loc.notifications_empty,
              ),
              LoadStatus.success => ListView(
                padding: SdContentPaddingV5.gutter.copyWith(
                  bottom: SdContentPaddingV5.detailBottom(context),
                ),
                children: <Widget>[
                  for (final (String title, List<NotificationEntity> group)
                      in <(String, List<NotificationEntity>)>[
                        (context.loc.notifications_today, recent),
                        (context.loc.notifications_earlier, earlier),
                      ])
                    if (group.isNotEmpty) ...<Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: SdSpacingConstant.h12,
                          bottom: SdSpacingConstant.h8,
                        ),
                        child: Text(
                          title.toUpperCase(),
                          style: context.textTheme5.labelSmall!.faint5(context).copyWith(
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      for (final (int i, NotificationEntity n) in group.indexed)
                        Padding(
                          padding: EdgeInsets.only(bottom: SdSpacingConstant.h8),
                          child: SdFadeInV5(
                            index: i,
                            child: NotificationTile(notification: n, onTap: () => open(n)),
                          ),
                        ),
                    ],
                ],
              ),
            },
          ),
        );
      },
    ),
  );
}
