import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/presentation/my_order/components/my_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';

import 'components/my_order_app_bar.dart';
import 'components/my_order_skeleton.dart';
import 'my_order_controller.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<MyOrderController>()
                ..onRefresh(currentTab: OrderStatusExt.defaultFirstTab),
        ),
      ],
      child: _MyOrderView(),
    );
  }
}

class _MyOrderView extends StatefulWidget {
  const _MyOrderView();

  @override
  State<_MyOrderView> createState() => __MyOrderViewState();
}

class __MyOrderViewState extends State<_MyOrderView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<int> _selectedTabIndex;

  @override
  void initState() {
    _selectedTabIndex = ValueNotifier<int>(0);
    _tabController = TabController(
      length: OrderStatusExt.tabs.length,
      vsync: this,
    );
    // Handle tab action => TAP & SWIPE
    _tabController.addListener(() {
      final newIndex = _tabController.index;

      if (_selectedTabIndex.value != newIndex) {
        _selectedTabIndex.value = newIndex;
        _onChangeTab(newIndex);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onChangeTab(int newIndex) {
    context.read<MyOrderController>().onChangeTab(
      tabIndex: _selectedTabIndex.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SdSafeAreaScaffoldV5(
      backgroundColor: context.colorTheme.pageDefault,
      contentBgColor: context.colorTheme.pageDefault,
      appBar: MyOrderAppBar(tabController: _tabController),
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: OrderStatusExt.tabs
                  .map((e) => _TabContent(tabValue: e))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabContent extends StatefulWidget {
  const _TabContent({required this.tabValue});
  final OrderStatus tabValue;

  @override
  State<_TabContent> createState() => __TabContentState();
}

class __TabContentState extends State<_TabContent>
    with AutomaticKeepAliveClientMixin {
  Future _onRefresh() async {
    context.read<MyOrderController>().onRefresh(currentTab: widget.tabValue);
  }

  Future _onLoadMore({required bool canLoadMore}) async {
    context.read<MyOrderController>().onLoadMore(
      currentTab: widget.tabValue,
      canLoadMore: canLoadMore,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshWrapper(
      onRefresh: _onRefresh,
      child: BlocBuilder<MyOrderController, MyOrderState>(
        buildWhen: (previous, current) {
          return (current is MyOrderLoadingState ||
                  current is MyOrderLoadedState) &&
              current.currentTab == widget.tabValue;
        },
        builder: (context, state) {
          if (state is MyOrderLoadingState) {
            return MyOrderSkeleton();
          } else if (state is MyOrderLoadedState) {
            return state.items.isEmpty
                ? EmptyView()
                : SdListViewLoadMoreV5(
                    padding: EdgeInsets.all(SdSpacingV5.s10),
                    items: state.items,
                    canLoadMore: state.canLoadMore,
                    physics: const AlwaysScrollableScrollPhysics(),
                    onLoadMore: () =>
                        _onLoadMore(canLoadMore: state.canLoadMore),
                    separatorBuilder: (_, __) =>
                        SdVerticalSpacingV5(value: SdSpacingV5.s10),
                    itemBuilder: (_, index) {
                      return MyOrderCard(order: state.items[index]);
                    },
                  );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
