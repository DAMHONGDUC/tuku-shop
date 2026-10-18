import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'components/notification_card.dart';
import 'components/notifications_skeleton.dart';
import 'notifications_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationsController>()..getData(),
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Scaffold(
      backgroundColor: colors.pageDefault,
      appBar: SdAppBarV5(
        titleText: context.loc.notifications_title,
        backgroundColor: colors.pageDefault,
        noElevation: true,
      ),
      body: BlocBuilder<NotificationsController, NotificationsState>(
        builder: (context, state) => switch (state) {
          NotificationsLoadedState() => _Body(state: state),
          NotificationsErrorState() => Padding(
            padding: EdgeInsets.all(SdSpacingV5.s16),
            child: SectionError(
              onRetry: context.read<NotificationsController>().getData,
            ),
          ),
          _ => const NotificationsSkeleton(),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final NotificationsLoadedState state;

  @override
  Widget build(BuildContext context) {
    final items = state.visible;
    final fresh = items.where((e) => !e.isRead).toList();
    final earlier = items.where((e) => e.isRead).toList();

    return RefreshIndicator(
      onRefresh: context.read<NotificationsController>().getData,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _Filters(selected: state.filter)),
          if (items.isEmpty)
            SliverToBoxAdapter(
              child: EmptyState(
                icon: Icons.notifications_none_rounded,
                title: context.loc.notifications_empty_title,
                message: context.loc.notifications_empty_message,
              ),
            ),
          if (fresh.isNotEmpty) ...[
            _Header(context.loc.notifications_new),
            _List(items: fresh),
          ],
          if (earlier.isNotEmpty) ...[
            _Header(context.loc.notifications_earlier),
            _List(items: earlier),
          ],
          SliverToBoxAdapter(
            child: SdVerticalSpacingV5(value: SdSpacingV5.s32),
          ),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({required this.selected});

  final NotificationFilter selected;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final labels = {
      NotificationFilter.all: loc.notifications_filter_all,
      NotificationFilter.orders: loc.notifications_filter_orders,
      NotificationFilter.offers: loc.notifications_filter_offers,
      NotificationFilter.updates: loc.notifications_filter_updates,
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(
        SdSpacingV5.s16,
        SdSpacingV5.s8,
        SdSpacingV5.s16,
        SdSpacingV5.s4,
      ),
      child: Row(
        children: [
          for (final entry in labels.entries) ...[
            AppChip(
              label: entry.value,
              selected: entry.key == selected,
              onTap: () => context.read<NotificationsController>().selectFilter(
                entry.key,
              ),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s8),
          ],
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(
        SdSpacingV5.s16,
        SdSpacingV5.s16,
        SdSpacingV5.s16,
        SdSpacingV5.s8,
      ),
      sliver: SliverToBoxAdapter(
        child: Text(
          title,
          style: SdTextStyleV5.heading16().wColor(
            context.colorTheme.textDefault,
          ),
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.items});

  final List<NotificationEntity> items;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
      sliver: SliverList.separated(
        itemCount: items.length,
        separatorBuilder: (_, _) => SdVerticalSpacingV5(value: SdSpacingV5.s8),
        itemBuilder: (context, index) {
          final item = items[index];
          return NotificationCard(
            notification: item,
            onTap: _target(context, item) == null
                ? null
                : () => context.push(_target(context, item)!),
          );
        },
      ),
    );
  }

  /// Where a notification leads: its order, or the list it advertises.
  static String? _target(BuildContext context, NotificationEntity item) {
    return switch (item.type) {
      NotificationType.orderUpdate when item.relatedItemId != null =>
        MyOrderRoutes.orderLocation(item.relatedItemId!),
      NotificationType.promotion => ProductRoutes.productListLocation(
        title: context.loc.home_flash_sale,
        onSaleOnly: true,
      ),
      NotificationType.newProduct => ProductRoutes.productListLocation(
        title: context.loc.home_new_arrivals,
        tag: ProductTag.newArrival.name,
      ),
      _ => null,
    };
  }
}
