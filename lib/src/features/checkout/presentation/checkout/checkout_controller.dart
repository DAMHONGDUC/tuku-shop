import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

part 'checkout_state.dart';

class CheckoutController extends Cubit<CheckoutState> {
  CheckoutController({
    required this._getAddresses,
    required this._getPaymentMethods,
    required this._getDeliveryOptions,
    required this._placeOrder,
    required this._clearCart,
  }) : super(const CheckoutState());

  final GetAddressesUsecase _getAddresses;
  final GetPaymentMethodsUsecase _getPaymentMethods;
  final GetDeliveryOptionsUsecase _getDeliveryOptions;
  final PlaceOrderUsecase _placeOrder;
  final ClearCartUsecase _clearCart;

  Future<void> load() async {
    emit(const CheckoutState());

    final (
      Either<Failure, List<AddressEntity>> addresses,
      Either<Failure, List<PaymentMethodEntity>> payments,
      Either<Failure, List<DeliveryOptionEntity>> delivery,
    ) = await (
      _getAddresses(const NoParams()),
      _getPaymentMethods(const NoParams()),
      _getDeliveryOptions(const NoParams()),
    ).wait;

    if (addresses.isLeft() || payments.isLeft() || delivery.isLeft()) {
      emit(const CheckoutState(status: LoadStatus.failure));
      return;
    }

    final List<AddressEntity> a = addresses.getOrElse(
      () => const <AddressEntity>[],
    );
    final List<PaymentMethodEntity> p = payments.getOrElse(
      () => const <PaymentMethodEntity>[],
    );
    final List<DeliveryOptionEntity> d = delivery.getOrElse(
      () => const <DeliveryOptionEntity>[],
    );

    emit(
      CheckoutState(
        status: LoadStatus.success,
        addresses: a,
        payments: p,
        deliveryOptions: d,
        addressId:
            (a.firstWhereOrNull((AddressEntity e) => e.isDefault) ??
                    a.firstOrNull)
                ?.id,
        paymentId:
            (p.firstWhereOrNull((PaymentMethodEntity e) => e.isDefault) ??
                    p.firstOrNull)
                ?.id,
        deliveryId: d.firstOrNull?.id,
      ),
    );
  }

  /// Re-reads the address book after the form closes, picking [selectId]
  /// when it is the address just added.
  Future<void> refreshAddresses({String? selectId}) async {
    final Either<Failure, List<AddressEntity>> result = await _getAddresses(
      const NoParams(),
    );

    result.fold((Failure _) {}, (List<AddressEntity> a) {
      final String? keep = selectId ?? state.addressId;
      emit(
        state.copyWith(
          addresses: a,
          addressId: a.any((AddressEntity e) => e.id == keep)
              ? keep
              : a.firstOrNull?.id,
        ),
      );
    });
  }

  void selectAddress(String id) => emit(state.copyWith(addressId: id));

  void selectPayment(String id) => emit(state.copyWith(paymentId: id));

  void selectDelivery(String id) => emit(state.copyWith(deliveryId: id));

  /// Places the order for [cart] and empties the bag.
  Future<void> placeOrder(CartEntity cart) async {
    final AddressEntity? address = state.address;
    final PaymentMethodEntity? payment = state.payment;
    final DeliveryOptionEntity? delivery = state.delivery;

    if (address == null ||
        payment == null ||
        delivery == null ||
        state.placing) {
      return;
    }

    emit(state.copyWith(placing: true, failure: () => null));

    final Either<Failure, OrderEntity> result = await _placeOrder(
      PlaceOrderParams(
        items: cart.items
            .map(
              (CartItemEntity i) => OrderItemEntity(
                productId: i.productId,
                name: i.name,
                image: i.image,
                color: i.color,
                size: i.size,
                quantity: i.quantity,
                unitPrice: i.unitPrice,
              ),
            )
            .toList(),
        recipient: address.fullName,
        phone: address.phone,
        address: address.oneLine,
        paymentType: payment.type,
        paymentLabel: <String?>[
          payment.label,
          payment.detail?.split(' · ').first,
        ].whereType<String>().join(' '),
        deliveryOptionId: delivery.id,
        deliveryMaxDays: delivery.maxDays,
        subtotal: cart.subtotal,
        shippingFee: shippingFor(cart),
        discount: cart.discount,
        promoCode: cart.promo?.code,
      ),
    );

    await result.fold(
      (Failure f) async =>
          emit(state.copyWith(placing: false, failure: () => f)),
      (OrderEntity order) async {
        await _clearCart(const NoParams());
        emit(state.copyWith(placing: false, placedOrderId: order.id));
      },
    );
  }

  /// The delivery fee for [cart] with the chosen option.
  double shippingFor(CartEntity cart) =>
      state.delivery?.feeFor(qualifiesForFree: cart.qualifiesForFreeShipping) ??
      cart.estimatedShipping;
}
