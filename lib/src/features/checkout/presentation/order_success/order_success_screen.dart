import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import 'order_success_controller.dart';

/// The peak of the flow: a check that pops in, then the order and two clear
/// next steps.
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrderSuccessController>()..load(orderId),
      child: _View(orderId: orderId),
    );
  }
}

class _View extends StatelessWidget {
  const _View({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(HomeRoutes.home.fullPath);
      },
      child: Scaffold(
        backgroundColor: colors.pageDefault,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(SdSpacingV5.s24),
            child: Column(
              children: [
                const Spacer(),
                const _CheckBurst(),
                SdVerticalSpacingV5(value: SdSpacingV5.s24),
                Text(
                  context.loc.success_title,
                  style: SdTextStyleV5.heading24().wColor(colors.textDefault),
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s8),
                Text(
                  context.loc.success_message,
                  textAlign: TextAlign.center,
                  style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s24),
                BlocBuilder<OrderSuccessController, OrderEntity?>(
                  builder: (context, order) => AnimatedSwitcher(
                    duration: UIConstants.navNormal,
                    child: order == null
                        ? const SkeletonBox(
                            height: 120,
                            radius: UIConstants.cardRadius,
                          )
                        : _SummaryCard(order: order),
                  ),
                ),
                const Spacer(),
                AppButton(
                  label: context.loc.success_track,
                  onTap: () =>
                      context.go(MyOrderRoutes.detailLocation(orderId)),
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s12),
                AppButton(
                  label: context.loc.success_continue,
                  style: AppButtonStyle.soft,
                  onTap: () => context.go(HomeRoutes.home.fullPath),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();

    Widget row(String label, String value) => Padding(
      padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
          ),
          Text(
            value,
            style: SdTextStyleV5.body14().wSemiBold().copyWith(
              color: colors.textDefault,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      decoration: BoxDecoration(
        color: colors.cardDefault,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      ),
      child: Column(
        children: [
          row(context.loc.success_order, '#${order.id}'),
          row(
            context.loc.success_arrives,
            DateFormat.MMMEd(locale).format(order.estimatedDelivery),
          ),
          row(context.loc.cart_total, AppFormat.price(order.total)),
        ],
      ),
    );
  }
}

/// A check that scales in with an overshoot, inside two soft rings.
class _CheckBurst extends StatelessWidget {
  const _CheckBurst();

  @override
  Widget build(BuildContext context) {
    final success = context.colorTheme.success;
    final animate = !MediaQuery.disableAnimationsOf(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: animate ? 0 : 1, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.elasticOut,
      builder: (context, t, child) => Transform.scale(scale: t, child: child),
      child: Container(
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: success.withValues(alpha: 0.06),
        ),
        alignment: Alignment.center,
        child: Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: success.withValues(alpha: 0.14),
          ),
          child: Icon(Icons.check_rounded, size: 48, color: success),
        ),
      ),
    );
  }
}
