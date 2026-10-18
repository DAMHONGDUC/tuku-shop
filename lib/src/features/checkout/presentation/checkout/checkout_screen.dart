import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

import 'checkout_controller.dart';

/// One scroll in decision order: what you buy, where it goes, how it ships,
/// how you pay, a voucher, then Place order in the thumb zone.
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, this.lineIds = const {}});

  final Set<String> lineIds;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CheckoutController>()..init(lineIds: lineIds),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return BlocConsumer<CheckoutController, CheckoutState>(
      listenWhen: (a, b) =>
          a.placedOrder != b.placedOrder || a.placeFailures != b.placeFailures,
      listener: (context, state) {
        final order = state.placedOrder;
        if (order != null) {
          context.go(CheckoutRoutes.orderSuccessLocation(order.id));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.loc.checkout_place_failed)),
          );
        }
      },
      builder: (context, state) {
        return SdKeyboardDismisserV5(
          child: Scaffold(
            backgroundColor: colors.pageDefault,
            appBar: SdAppBarV5(
              titleText: context.loc.checkout_title,
              backgroundColor: colors.pageDefault,
              noElevation: true,
            ),
            bottomNavigationBar: _PlaceOrderDock(state: state),
            body: ListView(
              padding: EdgeInsets.all(SdSpacingV5.s16),
              children: [
                _ItemsSection(state: state),
                SdVerticalSpacingV5(value: SdSpacingV5.s12),
                _AddressSection(state: state),
                SdVerticalSpacingV5(value: SdSpacingV5.s12),
                _ShippingSection(state: state),
                SdVerticalSpacingV5(value: SdSpacingV5.s12),
                _PaymentSection(state: state),
                SdVerticalSpacingV5(value: SdSpacingV5.s12),
                _VoucherSection(state: state),
                SdVerticalSpacingV5(value: SdSpacingV5.s12),
                _SummarySection(state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child, this.action});

  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    return Container(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      decoration: BoxDecoration(
        color: colors.cardDefault,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: SdTextStyleV5.heading16().wColor(colors.textDefault),
                ),
              ),
              ?action,
            ],
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s12),
          child,
        ],
      ),
    );
  }
}

/// Skeleton, error-with-retry or [loaded], by [status].
Widget _section(
  SectionStatus status, {
  required VoidCallback onRetry,
  required Widget Function() loaded,
  double skeletonHeight = 48,
}) => switch (status) {
  SectionStatus.loading => SkeletonBox(height: skeletonHeight),
  SectionStatus.error => SectionError(onRetry: onRetry),
  SectionStatus.loaded => loaded(),
};

class _ItemsSection extends StatelessWidget {
  const _ItemsSection({required this.state});

  final CheckoutState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final controller = context.read<CheckoutController>();

    return _Card(
      title: state.linesStatus == SectionStatus.loaded
          ? context.loc.checkout_items(state.lines.length)
          : context.loc.checkout_items_title,
      child: _section(
        state.linesStatus,
        onRetry: controller.loadLines,
        skeletonHeight: 80,
        loaded: () => Column(
          children: [
            for (final line in state.lines)
              Padding(
                padding: EdgeInsets.only(bottom: SdSpacingV5.s8),
                child: Row(
                  children: [
                    CatalogImage(
                      path: line.imageUrl,
                      width: 48,
                      height: 60,
                      borderRadius: SdSpacingV5.s8,
                    ),
                    SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            line.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: SdTextStyleV5.body14().wColor(
                              colors.textDefault,
                            ),
                          ),
                          Text(
                            '${line.colorName} · ${line.size} · ×${line.quantity}',
                            style: SdTextStyleV5.body12().wColor(
                              colors.textSubTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PriceText(price: line.total),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddressSection extends StatelessWidget {
  const _AddressSection({required this.state});

  final CheckoutState state;

  Future<void> _change(BuildContext context) async {
    final controller = context.read<CheckoutController>();
    final id = await context.push<String>(
      AddressRoutes.pickLocation(selectedId: state.address?.id),
    );
    // Reload either way: the user may have added or edited addresses.
    await controller.loadAddress(selectId: id);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final address = state.address;

    return _Card(
      title: context.loc.checkout_ship_to,
      action: state.addressStatus == SectionStatus.loaded
          ? GestureDetector(
              onTap: () => _change(context),
              child: Text(
                address == null
                    ? context.loc.address_add
                    : context.loc.checkout_change,
                style: SdTextStyleV5.body14().wSemiBold().wColor(
                  colors.primary,
                ),
              ),
            )
          : null,
      child: _section(
        state.addressStatus,
        onRetry: context.read<CheckoutController>().loadAddress,
        loaded: () => address == null
            ? Text(
                context.loc.checkout_no_address,
                style: SdTextStyleV5.body14().wColor(colors.sale),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined, color: colors.primary),
                  SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${address.fullName} · ${address.phone}',
                          style: SdTextStyleV5.body14().wSemiBold().wColor(
                            colors.textDefault,
                          ),
                        ),
                        SdVerticalSpacingV5(value: SdSpacingV5.s2),
                        Text(
                          address.singleLine,
                          style: SdTextStyleV5.body14().wColor(
                            colors.textSubTitle,
                          ),
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

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.selected,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailing,
    this.icon,
  });

  final bool selected;
  final String title;
  final String? subtitle;
  final String? trailing;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(SdSpacingV5.s12),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s8),
          child: Row(
            children: [
              AnimatedContainer(
                duration: UIConstants.navFast,
                width: SdSpacingV5.s20,
                height: SdSpacingV5.s20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? colors.primary : colors.borderDefault,
                    width: selected ? 6 : 2,
                  ),
                ),
              ),
              SdHorizontalSpacingV5(value: SdSpacingV5.s12),
              if (icon != null) ...[
                Icon(icon, size: SdSpacingV5.s20, color: colors.iconSecondary),
                SdHorizontalSpacingV5(value: SdSpacingV5.s8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: SdTextStyleV5.body14().wColor(colors.textDefault),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: SdTextStyleV5.body12().wColor(
                          colors.textSubTitle,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: SdTextStyleV5.body14().wSemiBold().wColor(
                    colors.textDefault,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShippingSection extends StatelessWidget {
  const _ShippingSection({required this.state});

  final CheckoutState state;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CheckoutController>();
    final subtotal = state.subtotal;

    return _Card(
      title: context.loc.checkout_shipping,
      child: _section(
        state.shippingStatus,
        onRetry: controller.loadShipping,
        skeletonHeight: 88,
        loaded: () => Column(
          children: [
            for (final m in state.shippingMethods)
              _OptionTile(
                selected: m.id == state.shippingId,
                title: m.name,
                subtitle: context.loc.checkout_shipping_days(
                  m.minDays,
                  m.maxDays,
                ),
                trailing:
                    m.feeFor(subtotal) == 0 ||
                        (m.id == 'standard' &&
                            state.voucher?.freeShipping == true)
                    ? context.loc.checkout_free
                    : AppFormat.price(m.feeFor(subtotal)),
                onTap: () => controller.selectShipping(m.id),
              ),
          ],
        ),
      ),
    );
  }
}

class _PaymentSection extends StatelessWidget {
  const _PaymentSection({required this.state});

  final CheckoutState state;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CheckoutController>();

    return _Card(
      title: context.loc.checkout_payment,
      child: _section(
        state.paymentStatus,
        onRetry: controller.loadPayment,
        skeletonHeight: 120,
        loaded: () => Column(
          children: [
            for (final m in state.paymentMethods)
              _OptionTile(
                selected: m.id == state.paymentId,
                title: m.name,
                icon: switch (m.type) {
                  PaymentType.cashOnDelivery => Icons.payments_outlined,
                  PaymentType.card => Icons.credit_card,
                  PaymentType.wallet => Icons.account_balance_wallet_outlined,
                },
                onTap: () => controller.selectPayment(m.id),
              ),
          ],
        ),
      ),
    );
  }
}

class _VoucherSection extends StatefulWidget {
  const _VoucherSection({required this.state});

  final CheckoutState state;

  @override
  State<_VoucherSection> createState() => _VoucherSectionState();
}

class _VoucherSectionState extends State<_VoucherSection> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final controller = context.read<CheckoutController>();
    final state = widget.state;
    final voucher = state.voucher;

    return _Card(
      title: context.loc.checkout_voucher,
      child: voucher != null
          ? Row(
              children: [
                Icon(Icons.local_offer, color: colors.success),
                SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                Expanded(
                  child: Text(
                    voucher.freeShipping
                        ? context.loc.checkout_voucher_free_shipping(
                            voucher.code,
                          )
                        : context.loc.checkout_voucher_percent(
                            voucher.code,
                            voucher.percentOff,
                          ),
                    style: SdTextStyleV5.body14().wColor(colors.textDefault),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _code.clear();
                    controller.removeVoucher();
                  },
                  child: Text(context.loc.cart_remove),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _code,
                        textCapitalization: TextCapitalization.characters,
                        style: SdTextStyleV5.body14().wColor(
                          colors.textDefault,
                        ),
                        decoration: InputDecoration(
                          hintText: context.loc.checkout_voucher_hint,
                          isDense: true,
                          errorText:
                              state.voucherStatus == VoucherStatus.invalid
                              ? context.loc.checkout_voucher_invalid
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              SdSpacingV5.s12,
                            ),
                          ),
                        ),
                        onChanged: (_) => controller.clearVoucherError(),
                        onSubmitted: controller.applyVoucher,
                      ),
                    ),
                    SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                    AppButton(
                      label: context.loc.checkout_apply,
                      style: AppButtonStyle.soft,
                      expand: false,
                      isLoading: state.voucherStatus == VoucherStatus.applying,
                      onTap: () => controller.applyVoucher(_code.text),
                    ),
                  ],
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s8),
                Text(
                  context.loc.checkout_voucher_try,
                  style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
                ),
              ],
            ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.state});

  final CheckoutState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final t = state.totals;

    Widget row(String label, String value, {Color? color, bool bold = false}) {
      final style = bold ? SdTextStyleV5.heading16() : SdTextStyleV5.body14();
      return Padding(
        padding: EdgeInsets.only(bottom: SdSpacingV5.s8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: style.wColor(
                bold ? colors.textDefault : colors.textSubTitle,
              ),
            ),
            Text(
              value,
              style: style.copyWith(
                color: color ?? colors.textDefault,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      );
    }

    return _Card(
      title: context.loc.checkout_summary,
      child: Column(
        children: [
          row(context.loc.cart_subtotal, AppFormat.price(t.subtotal)),
          if (t.discount > 0)
            row(
              context.loc.checkout_discount,
              '−${AppFormat.price(t.discount)}',
              color: colors.success,
            ),
          row(
            context.loc.cart_shipping,
            t.shippingFee == 0
                ? context.loc.checkout_free
                : AppFormat.price(t.shippingFee),
            color: t.shippingFee == 0 ? colors.success : null,
          ),
          Divider(color: colors.borderDefault),
          SdVerticalSpacingV5(value: SdSpacingV5.s4),
          row(context.loc.cart_total, AppFormat.price(t.total), bold: true),
        ],
      ),
    );
  }
}

class _PlaceOrderDock extends StatelessWidget {
  const _PlaceOrderDock({required this.state});

  final CheckoutState state;

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
        SdSpacingV5.s12 + MediaQuery.paddingOf(context).bottom,
      ),
      child: AppButton(
        label: context.loc.checkout_place_order(
          AppFormat.price(state.totals.total),
        ),
        isLoading: state.isPlacing,
        onTap: state.canPlace
            ? () => context.read<CheckoutController>().placeOrder()
            : null,
      ),
    );
  }
}
