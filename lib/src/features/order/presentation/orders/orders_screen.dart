import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import 'components/order_card.dart';
import 'orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<OrdersController>(
    create: (BuildContext _) => getIt<OrdersController>()..load(),
    child: BlocBuilder<OrdersController, OrdersState>(
      builder: (BuildContext context, OrdersState state) {
        final OrdersController controller = context.read<OrdersController>();
        final List<OrderEntity> visible = state.visible;

        return SdScaffoldV5(
          appBar: SdAppBarV5(title: context.loc.orders_title),
          body: Column(
            children: <Widget>[
              SizedBox(height: SdSpacingConstant.h4),
              SdTabsV5(
                labels: <String>[
                  context.loc.orders_filter_all,
                  context.loc.orders_filter_active,
                  context.loc.orders_filter_delivered,
                  context.loc.orders_filter_cancelled,
                ],
                selectedIndex: state.filter.index,
                onSelected: (int i) =>
                    controller.setFilter(OrdersFilter.values[i]),
              ),
              SizedBox(height: SdSpacingConstant.h12),
              Expanded(
                child: FadeSwitcher(
                  child: switch (state.status) {
                    LoadStatus.loading => const _OrdersSkeleton(),
                    LoadStatus.failure => ErrorView(onRetry: controller.load),
                    LoadStatus.success when visible.isEmpty => SdEmptyStateV5(
                      key: ValueKey<OrdersFilter>(state.filter),
                      icon: Symbols.receipt_long_rounded,
                      title: context.loc.orders_empty_title,
                      message: context.loc.orders_empty_message,
                      action: SdButtonV5(
                        variant: SdButtonVariantV5.primary,
                        label: context.loc.action_start_shopping,
                        onPressed: () => context.go(AppRoutes.shop.path),
                      ),
                    ),
                    LoadStatus.success => RefreshIndicator.adaptive(
                      key: ValueKey<OrdersFilter>(state.filter),
                      onRefresh: controller.load,
                      color: context.sdTheme5.textPrimary,
                      child: ListView.separated(
                        padding: SdContentPaddingV5.gutter.copyWith(
                          bottom: SdContentPaddingV5.detailBottom(context),
                        ),
                        itemCount: visible.length,
                        separatorBuilder: (_, _) =>
                            SizedBox(height: SdContentPaddingV5.itemGap),
                        itemBuilder: (BuildContext context, int i) =>
                            SdFadeInV5(
                              index: i,
                              child: OrderCard(
                                order: visible[i],
                                onTap: () async {
                                  await context.push(
                                    AppRoutes.orderPath(visible[i].id),
                                  );
                                  await controller.load();
                                },
                              ),
                            ),
                      ),
                    ),
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

class _OrdersSkeleton extends StatelessWidget {
  const _OrdersSkeleton();

  @override
  Widget build(BuildContext context) => SdShimmerV5(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: SdContentPaddingV5.gutter,
      itemCount: 4,
      separatorBuilder: (_, _) => SizedBox(height: SdContentPaddingV5.itemGap),
      itemBuilder: (_, _) => SdSkeletonV5(height: SdSpacingConstant.h160),
    ),
  );
}
