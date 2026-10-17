import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import 'components/confetti.dart';
import 'components/success_check.dart';
import 'order_success_controller.dart';

/// The confirmation: a check that draws itself, a burst of confetti, then
/// the order number, when it arrives, and where to go next.
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({required this.orderId, super.key});

  final String orderId;

  @override
  Widget build(BuildContext context) => BlocProvider<OrderSuccessController>(
    create: (BuildContext _) => getIt<OrderSuccessController>()..load(orderId),
    child: PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? _) {
        if (!didPop) context.go(AppRoutes.home.path);
      },
      child: SdScaffoldV5(
        body: Stack(
          children: <Widget>[
            const Positioned.fill(child: IgnorePointer(child: Confetti())),
            SafeArea(
              child: Padding(
                padding: SdContentPaddingV5.gutter,
                child: BlocBuilder<OrderSuccessController, OrderSuccessState>(
                  builder: (BuildContext context, OrderSuccessState state) =>
                      Column(
                        children: <Widget>[
                          const Spacer(flex: 2),
                          const SuccessCheck(),
                          SizedBox(height: SdSpacingConstant.h32),
                          SdFadeInV5(
                            index: 6,
                            child: Text(
                              context.loc.success_title,
                              textAlign: TextAlign.center,
                              style: context.textTheme5.displaySmall,
                            ),
                          ),
                          SizedBox(height: SdSpacingConstant.h10),
                          SdFadeInV5(
                            index: 7,
                            child: Text(
                              context.loc.success_message,
                              textAlign: TextAlign.center,
                              style: context.textTheme5.bodyMedium!.muted5(context),
                            ),
                          ),
                          SizedBox(height: SdSpacingConstant.h24),
                          if (state.order != null)
                            SdFadeInV5(index: 8, child: _OrderFacts(order: state.order!)),
                          const Spacer(flex: 3),
                          SdFadeInV5(
                            index: 9,
                            child: SdButtonV5(
                              variant: SdButtonVariantV5.primary,
                              size: SdButtonSizeV5.large,
                              label: context.loc.success_track,
                              icon: Symbols.local_shipping_rounded,
                              expand: true,
                              onPressed: state.order == null
                                  ? null
                                  : () {
                                      context.go(AppRoutes.home.path);
                                      context.push(AppRoutes.orderPath(state.order!.id));
                                    },
                            ),
                          ),
                          SizedBox(height: SdSpacingConstant.h12),
                          SdFadeInV5(
                            index: 10,
                            child: SdButtonV5(
                              variant: SdButtonVariantV5.text,
                              label: context.loc.success_continue,
                              expand: true,
                              onPressed: () => context.go(AppRoutes.home.path),
                            ),
                          ),
                          SizedBox(height: SdSpacingConstant.h12),
                        ],
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _OrderFacts extends StatelessWidget {
  const _OrderFacts({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) => SdCardV5(
    layer: SdCardLayerV5.sunken,
    child: Column(
      children: <Widget>[
        _Fact(label: context.loc.success_order_number, value: order.code),
        SdDividerV5(spacing: SdSpacingConstant.h20),
        _Fact(
          label: context.loc.success_eta,
          value: Formatters.date(order.estimatedDelivery, context.localeName),
        ),
        SdDividerV5(spacing: SdSpacingConstant.h20),
        _Fact(label: context.loc.summary_total, value: Formatters.currency(order.total)),
      ],
    ),
  );
}

class _Fact extends StatelessWidget {
  const _Fact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Expanded(child: Text(label, style: context.textTheme5.bodyMedium!.muted5(context))),
      Text(value, style: context.textTheme5.titleSmall!.tabular5),
    ],
  );
}
