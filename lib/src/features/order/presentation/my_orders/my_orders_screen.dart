import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/presentation/widgets/order_card.dart';
import 'package:tuku_shop/src/features/order/presentation/widgets/order_status_text.dart';

import 'orders_list_controller.dart';

/// My orders: one tab per status; a tab loads the first time it opens.
class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key, this.initialStatus});

  final OrderStatus? initialStatus;

  @override
  Widget build(BuildContext context) {
    final tabs = OrderStatusExt.tabs;
    final colors = context.colorTheme;

    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialStatus == null
          ? 0
          : tabs.indexOf(initialStatus!).clamp(0, tabs.length - 1),
      child: Scaffold(
        backgroundColor: colors.pageDefault,
        appBar: AppTopBar(
          title: context.loc.orders_title,
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelStyle: SdTextStyleV5.body14().wSemiBold(),
            unselectedLabelStyle: SdTextStyleV5.body14(),
            tabs: [for (final s in tabs) Tab(text: s.label(context))],
          ),
        ),
        body: TabBarView(
          children: [for (final s in tabs) _OrdersTab(status: s)],
        ),
      ),
    );
  }
}

class _OrdersTab extends StatefulWidget {
  const _OrdersTab({required this.status});

  final OrderStatus status;

  @override
  State<_OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<_OrdersTab>
    with AutomaticKeepAliveClientMixin {
  late final _controller = getIt<OrdersListController>()..load(widget.status);

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _controller,
      child: BlocBuilder<OrdersListController, OrdersListState>(
        builder: (context, state) {
          final padding = EdgeInsets.fromLTRB(
            SdSpacingV5.s16,
            SdSpacingV5.s16,
            SdSpacingV5.s16,
            MediaQuery.paddingOf(context).bottom + SdSpacingV5.s24,
          );
          return switch (state.status) {
            OrdersListStatus.loading => ListView(
              padding: padding,
              children: [
                for (var i = 0; i < 3; i++) ...[
                  const SkeletonBox(
                    height: 150,
                    radius: UIConstants.cardRadius,
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s12),
                ],
              ],
            ),
            OrdersListStatus.error => Padding(
              padding: padding,
              child: SectionError(
                onRetry: () => _controller.load(widget.status),
              ),
            ),
            OrdersListStatus.loaded when state.items.isEmpty => Center(
              child: EmptyState(
                icon: Icons.receipt_long_outlined,
                title: context.loc.orders_empty_title,
                message: context.loc.orders_empty_message,
                actionLabel: context.loc.common_start_shopping,
                onAction: () => context.go(HomeRoutes.home.fullPath),
              ),
            ),
            OrdersListStatus.loaded => LoadMoreListener(
              onLoadMore: _controller.loadMore,
              child: RefreshWrapper(
                onRefresh: () => _controller.load(widget.status, silent: true),
                child: ListView.separated(
                  padding: padding,
                  itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
                  separatorBuilder: (_, _) =>
                      SdVerticalSpacingV5(value: SdSpacingV5.s12),
                  itemBuilder: (context, index) {
                    if (index >= state.items.length) {
                      return const SkeletonBox(
                        height: 150,
                        radius: UIConstants.cardRadius,
                      );
                    }
                    final order = state.items[index];
                    return OrderCard(
                      order: order,
                      onTap: () =>
                          context.push(MyOrderRoutes.detailLocation(order.id)),
                    );
                  },
                ),
              ),
            ),
          };
        },
      ),
    );
  }
}
