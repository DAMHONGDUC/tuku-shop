import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/cart_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

import 'checkout_controller.dart';
import 'components/address_picker_sheet.dart';
import 'components/checkout_labels.dart';
import 'components/checkout_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<CheckoutController>(
    create: (BuildContext _) => getIt<CheckoutController>()..load(),
    child: BlocConsumer<CheckoutController, CheckoutState>(
      listenWhen: (CheckoutState a, CheckoutState b) =>
          a.placedOrderId != b.placedOrderId ||
          (b.failure != null && a.failure != b.failure),
      listener: (BuildContext context, CheckoutState state) {
        if (state.placedOrderId != null) {
          HapticFeedback.heavyImpact();
          context.pushReplacement(AppRoutes.orderSuccessPath(state.placedOrderId!));
        } else if (state.failure != null) {
          SdSnackBarUtilsV5.error(context, context.loc.checkout_failed);
        }
      },
      builder: (BuildContext context, CheckoutState state) => SdScaffoldV5(
        appBar: SdAppBarV5(title: context.loc.checkout_title),
        bottomBar: state.status == LoadStatus.success ? const _PlaceOrderBar() : null,
        body: FadeSwitcher(
          child: switch (state.status) {
            LoadStatus.loading => const Center(child: SdLoadingV5()),
            LoadStatus.failure => ErrorView(onRetry: context.read<CheckoutController>().load),
            LoadStatus.success => _CheckoutBody(state: state),
          },
        ),
      ),
    ),
  );
}

class _CheckoutBody extends StatelessWidget {
  const _CheckoutBody({required this.state});

  final CheckoutState state;

  Future<void> _addAddress(BuildContext context) async {
    final CheckoutController controller = context.read<CheckoutController>();
    final Object? saved = await context.push<Object?>(AppRoutes.addressForm.path);

    await controller.refreshAddresses(selectId: saved is String ? saved : null);
  }

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = context.read<CheckoutController>();
    final CartEntity cart = context.watch<CartController>().state;
    final AddressEntity? address = state.address;

    return ListView(
      padding: SdContentPaddingV5.gutter.copyWith(
        top: SdSpacingConstant.h8,
        bottom: SdSpacingConstant.h24,
      ),
      children: <Widget>[
        SdFadeInV5(
          child: CheckoutSection(
            step: 1,
            title: context.loc.checkout_address,
            action: address == null ? null : context.loc.action_change,
            onAction: () => showAddressPicker(
              context,
              addresses: state.addresses,
              selectedId: state.addressId,
              onSelected: controller.selectAddress,
              onAdd: () => _addAddress(context),
            ),
            child: address == null
                ? SdButtonV5(
                    variant: SdButtonVariantV5.outlined,
                    label: context.loc.address_add,
                    icon: Symbols.add_location_alt_rounded,
                    expand: true,
                    onPressed: () => _addAddress(context),
                  )
                : SdCardV5(
                    layer: SdCardLayerV5.outlined,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SdIconV5(Symbols.location_on_rounded, color: context.sdTheme5.accent, fill: 1),
                        SizedBox(width: SdSpacingConstant.w12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${address.fullName}  ·  ${address.label}',
                                style: context.textTheme5.titleSmall,
                              ),
                              SizedBox(height: SdSpacingConstant.h2),
                              Text(address.phone, style: context.textTheme5.bodySmall!.muted5(context)),
                              SizedBox(height: SdSpacingConstant.h4),
                              Text(address.oneLine, style: context.textTheme5.bodyMedium!.muted5(context)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        SdFadeInV5(
          index: 1,
          child: CheckoutSection(
            step: 2,
            title: context.loc.checkout_delivery,
            child: Column(
              children: <Widget>[
                for (final DeliveryOptionEntity d in state.deliveryOptions)
                  Padding(
                    padding: EdgeInsets.only(bottom: SdSpacingConstant.h10),
                    child: SdSelectableCardV5(
                      title: context.deliveryName(d.id),
                      subtitle: context.deliveryEta(d),
                      icon: switch (d.id) {
                        'express' => Symbols.bolt_rounded,
                        'nextDay' => Symbols.rocket_launch_rounded,
                        _ => Symbols.local_shipping_rounded,
                      },
                      selected: d.id == state.deliveryId,
                      onSelected: () => controller.selectDelivery(d.id),
                      trailing: Text(
                        d.feeFor(qualifiesForFree: cart.qualifiesForFreeShipping) == 0
                            ? context.loc.summary_free
                            : Formatters.currency(d.fee),
                        style: context.textTheme5.labelLarge!.tabular5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SdFadeInV5(
          index: 2,
          child: CheckoutSection(
            step: 3,
            title: context.loc.checkout_payment,
            child: Column(
              children: <Widget>[
                for (final PaymentMethodEntity p in state.payments)
                  Padding(
                    padding: EdgeInsets.only(bottom: SdSpacingConstant.h10),
                    child: SdSelectableCardV5(
                      title: context.paymentName(p),
                      subtitle: p.detail,
                      icon: paymentIcon(p.type),
                      selected: p.id == state.paymentId,
                      onSelected: () => controller.selectPayment(p.id),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SdFadeInV5(
          index: 3,
          child: CheckoutSection(
            step: 4,
            title: context.loc.checkout_items(cart.itemCount),
            child: SizedBox(
              height: SdSpacingConstant.h96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: cart.items.length,
                separatorBuilder: (_, _) => SizedBox(width: SdSpacingConstant.w8),
                itemBuilder: (BuildContext context, int i) {
                  final CartItemEntity item = cart.items[i];

                  return Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      SizedBox(
                        width: SdSpacingConstant.h96 * 0.8,
                        height: SdSpacingConstant.h96,
                        child: AppImage(item.image, borderRadius: SdRadiusV5.thumbnailAll),
                      ),
                      if (item.quantity > 1)
                        Positioned(
                          top: SdSpacingConstant.h4,
                          right: SdSpacingConstant.w4,
                          child: SdBadgeV5(label: '×${item.quantity}', tone: SdBadgeToneV5.inverse),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        SdFadeInV5(
          index: 4,
          child: OrderSummaryCard(
            subtotal: cart.subtotal,
            discount: cart.discount,
            shipping: controller.shippingFor(cart),
            total: cart.subtotal - cart.discount + controller.shippingFor(cart),
            savings: cart.savings,
            promoCode: cart.promo?.code,
          ),
        ),
        SizedBox(height: SdSpacingConstant.h16),
        Row(
          children: <Widget>[
            SdIconV5(Symbols.lock_rounded, size: SdIconV5.smallSize, color: context.sdTheme5.textTertiary),
            SizedBox(width: SdSpacingConstant.w6),
            Expanded(
              child: Text(
                context.loc.checkout_secure_note,
                style: context.textTheme5.bodySmall!.faint5(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlaceOrderBar extends StatelessWidget {
  const _PlaceOrderBar();

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = context.watch<CheckoutController>();
    final CartEntity cart = context.watch<CartController>().state;
    final double total = cart.subtotal - cart.discount + controller.shippingFor(cart);

    return Container(
      padding: EdgeInsets.fromLTRB(
        SdContentPaddingV5.horizontal,
        SdSpacingConstant.h12,
        SdContentPaddingV5.horizontal,
        SdContentPaddingV5.detailBottom(context),
      ),
      decoration: BoxDecoration(
        color: context.sdTheme5.surface,
        border: Border(top: BorderSide(color: context.sdTheme5.divider)),
      ),
      child: SdButtonV5(
        variant: SdButtonVariantV5.primary,
        size: SdButtonSizeV5.large,
        label: '${context.loc.checkout_place_order}  ·  ${Formatters.currency(total)}',
        icon: Symbols.lock_rounded,
        expand: true,
        busy: controller.state.placing,
        onPressed: controller.state.canPlace && !cart.isEmpty
            ? () => controller.placeOrder(cart)
            : null,
      ),
    );
  }
}
