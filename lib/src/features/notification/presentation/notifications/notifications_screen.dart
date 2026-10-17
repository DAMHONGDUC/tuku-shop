import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/presentation/notifications/components/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';

import 'components/notification_app_bar.dart';
import 'components/notification_category_card.dart';
import 'components/notifications_skeleton.dart';
import 'notifications_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<NotificationsController>()..getData(),
        ),
      ],
      child: _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  Future _onRefresh(BuildContext context) async {
    context.read<NotificationsController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return SdSafeAreaScaffoldV5(
      backgroundColor: context.colorTheme.pageDefault,
      contentBgColor: context.colorTheme.pageDefault,
      appBar: NotificationAppBar(),
      child: RefreshWrapper(
        onRefresh: () => _onRefresh(context),
        child: BlocConsumer<NotificationsController, NotificationsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          buildWhen: (previous, current) {
            return current is NotificationsLoadingState ||
                current is NotificationsLoadedState ||
                current is NotificationsErrorState;
          },
          builder: (context, state) {
            if (state is NotificationsLoadingState) {
              return NotificationsSkeleton();
            }
            if (state is NotificationsErrorState) {
              return EmptyView(message: state.errorMsg);
            }
            if (state is NotificationsLoadedState) {
              return _Body(notificationData: state.notificationData);
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.notificationData});

  final NotificationData notificationData;

  @override
  Widget build(BuildContext context) {
    final listNoti = notificationData.listNotification;
    final listNotiCategory = notificationData.listNotificationCategory;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s10),
      children: [
        SdListViewV5(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          items: listNotiCategory,
          separatorBuilder: (context, index) {
            return SdDividerV5();
          },
          itemBuilder: (context, index) {
            return NotificationCategoryCard(
              category: listNotiCategory[index],
              onTap: () {},
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(SdSpacingV5.s10),
          child: SectionHeader(
            title: 'Order update information',
            hasBottomSpacing: false,
          ),
        ),
        SdListViewV5(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          items: listNoti,
          separatorBuilder: (context, index) {
            return SdDividerV5();
          },
          itemBuilder: (_, index) {
            return NotificationCard(
              notification: listNoti[index],
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}
