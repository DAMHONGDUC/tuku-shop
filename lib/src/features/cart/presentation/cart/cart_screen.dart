import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

import 'cart_controller.dart';

/// The Cart tab, read from the app-wide [CartController].
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BlocConsumer<CartController, CartState>(
      listenWhen: (a, b) => b.failureCount > a.failureCount,
      listener: (context, state) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.loc.cart_update_failed))),
      builder: (context, state) {
        final controller = context.read<CartController>();
        final empty = state.status == CartStatus.loaded && state.lines.isEmpty;

        return Scaffold(
          backgroundColor: colors.pageDefault,
          body: SafeArea(
            bottom: false,
            child: RefreshWrapper(
              onRefresh: controller.load,
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                  SdSpacingV5.s24,
                ),
                children: [
                  Text(
                    state.itemCount > 0
                        ? context.loc.cart_title_count(state.itemCount)
                        : context.loc.cart_title,
                    style: SdTextStyleV5.heading24().wColor(colors.textDefault),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  switch (state.status) {
                    CartStatus.loading => const _CartSkeleton(),
                    CartStatus.error => SectionError(onRetry: controller.load),
                    CartStatus.loaded when empty => EmptyState(
                      icon: Icons.shopping_bag_outlined,
                      title: context.loc.cart_empty_title,
                      message: context.loc.cart_empty_message,
                      actionLabel: context.loc.common_start_shopping,
                      onAction: () => context.go(HomeRoutes.home.fullPath),
                    ),
                    CartStatus.loaded => _CartBody(state: state),
                  },
                ],
              ),
            ),
          ),
          bottomNavigationBar: state.status == CartStatus.loaded && !empty
              ? _CheckoutDock(summary: state.summary)
              : null,
        );
      },
    );
  }
}

class _CartBody extends StatelessWidget {
  const _CartBody({required this.state});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final summary = state.summary;
    final card = BoxDecoration(
      color: colors.cardDefault,
      borderRadius: BorderRadius.circular(UIConstants.cardRadius),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: card,
          padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
          child: Column(
            children: [
              for (var i = 0; i < state.lines.length; i++) ...[
                if (i > 0) Divider(height: 1, color: colors.borderDefault),
                _CartLineTile(line: state.lines[i]),
              ],
            ],
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Container(
          padding: EdgeInsets.all(SdSpacingV5.s12),
          decoration: BoxDecoration(
            color: colors.primarySoft,
            borderRadius: BorderRadius.circular(SdSpacingV5.s12),
          ),
          child: Row(
            children: [
              SdIconV5(
                iconData: Icons.local_shipping_outlined,
                iconSize: SdSpacingV5.s20,
                color: colors.primary,
              ),
              SdHorizontalSpacingV5(value: SdSpacingV5.s8),
              Expanded(
                child: Text(
                  summary.qualifiesForFreeShipping
                      ? context.loc.cart_free_shipping_unlocked
                      : context.loc.cart_free_shipping_nudge(
                          AppFormat.price(summary.amountToFreeShipping),
                        ),
                  style: SdTextStyleV5.body12().wColor(colors.textDefault),
                ),
              ),
            ],
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Container(
          decoration: card,
          padding: EdgeInsets.all(SdSpacingV5.s16),
          child: Column(
            children: [
              _SummaryRow(
                label: context.loc.cart_subtotal,
                value: AppFormat.price(summary.subtotal),
              ),
              if (summary.savings > 0) ...[
                SdVerticalSpacingV5(value: SdSpacingV5.s8),
                _SummaryRow(
                  label: context.loc.cart_savings,
                  value: '−${AppFormat.price(summary.savings)}',
                  valueColor: colors.success,
                ),
              ],
              SdVerticalSpacingV5(value: SdSpacingV5.s8),
              _SummaryRow(
                label: context.loc.cart_shipping,
                value: context.loc.cart_shipping_at_checkout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CartLineTile extends StatelessWidget {
  const _CartLineTile({required this.line});

  final CartLine line;

  Future<void> _remove(BuildContext context) async {
    final controller = context.read<CartController>();
    final messenger = ScaffoldMessenger.of(context);
    final removed = await controller.remove(line.id);
    if (removed == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.loc.cart_removed(line.name)),
          action: SnackBarAction(
            label: context.loc.common_undo,
            onPressed: () => controller.undoRemove(removed),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Dismissible(
      key: ValueKey(line.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _remove(context),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: SdSpacingV5.s16),
        color: colors.sale.withValues(alpha: 0.12),
        child: Icon(Icons.delete_outline, color: colors.sale),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.push(
                ProductRoutes.productDetailLocation(line.productId),
              ),
              child: CatalogImage(
                path: line.imageUrl,
                width: 72,
                height: 90,
                borderRadius: UIConstants.imageRadius,
              ),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          line.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: SdTextStyleV5.body14().wColor(
                            colors.textDefault,
                          ),
                        ),
                      ),
                      Semantics(
                        button: true,
                        label: context.loc.cart_remove,
                        child: InkWell(
                          onTap: () => _remove(context),
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(SdSpacingV5.s4),
                            child: Icon(
                              Icons.close,
                              size: SdSpacingV5.s18,
                              color: colors.iconSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${line.colorName} · ${line.size}',
                    style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s8),
                  Row(
                    children: [
                      Expanded(
                        child: PriceText(
                          price: line.unitPrice,
                          originalPrice: line.originalPrice,
                        ),
                      ),
                      QuantityStepper(
                        value: line.quantity,
                        max: line.maxQuantity,
                        min: 0,
                        onChanged: (q) => context
                            .read<CartController>()
                            .changeQuantity(line.id, q),
                      ),
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

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: SdTextStyleV5.body14().wColor(colors.textSubTitle)),
        Text(
          value,
          style: SdTextStyleV5.body14().copyWith(
            color: valueColor ?? colors.textDefault,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

class _CheckoutDock extends StatelessWidget {
  const _CheckoutDock({required this.summary});

  final CartSummary summary;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.cardDefault,
        border: Border(top: BorderSide(color: colors.borderDefault)),
      ),
      padding: EdgeInsets.fromLTRB(
        SdSpacingV5.s16,
        SdSpacingV5.s12,
        SdSpacingV5.s16,
        FloatingBottomNav.contentInset(context) - SdSpacingV5.s4,
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.cart_total,
                style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
              ),
              PriceText(
                price: summary.subtotal,
                style: SdTextStyleV5.heading20(),
              ),
            ],
          ),
          SdHorizontalSpacingV5(value: SdSpacingV5.s16),
          Expanded(
            child: AppButton(
              label: context.loc.cart_checkout,
              onTap: () => context.push(CheckoutRoutes.checkout.fullPath),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartSkeleton extends StatelessWidget {
  const _CartSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < 2; i++) ...[
          Row(
            children: [
              const SkeletonBox(width: 72, height: 90, radius: 12),
              SdHorizontalSpacingV5(value: SdSpacingV5.s12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(width: 160),
                    SizedBox(height: SdSpacingV5.s8),
                    SkeletonBox(width: 96, height: SdSpacingV5.s10),
                    SizedBox(height: SdSpacingV5.s16),
                    SkeletonBox(width: 64),
                  ],
                ),
              ),
            ],
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s16),
        ],
      ],
    );
  }
}
