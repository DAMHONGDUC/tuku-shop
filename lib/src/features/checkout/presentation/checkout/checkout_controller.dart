import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

part 'checkout_state.dart';

/// Checkout: four sections that load on their own requests, a voucher, and
/// placing the order.
class CheckoutController extends Cubit<CheckoutState> {
  CheckoutController({
    required this._getCart,
    required this._getAddresses,
    required this._getShippingMethods,
    required this._getPaymentMethods,
    required this._applyVoucher,
    required this._placeOrder,
    required this._removeCartLines,
    required this._addNotification,
  }) : super(const CheckoutState());

  final GetCartUsecase _getCart;
  final GetAddressesUsecase _getAddresses;
  final GetShippingMethodsUsecase _getShippingMethods;
  final GetPaymentMethodsUsecase _getPaymentMethods;
  final ApplyVoucherUsecase _applyVoucher;
  final PlaceOrderUsecase _placeOrder;
  final RemoveCartLinesUsecase _removeCartLines;
  final AddNotificationUsecase _addNotification;

  Set<String> _lineIds = const {};

  /// Checks out [lineIds] only, or the whole cart when empty.
  Future<void> init({Set<String> lineIds = const {}}) async {
    _lineIds = lineIds;
    await Future.wait([
      loadLines(),
      loadAddress(),
      loadShipping(),
      loadPayment(),
    ]);
  }

  Future<void> loadLines() async {
    emit(state.copyWith(linesStatus: SectionStatus.loading));
    final result = await _getCart.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(linesStatus: SectionStatus.error)),
      (lines) => emit(
        state.copyWith(
          linesStatus: SectionStatus.loaded,
          lines: _lineIds.isEmpty
              ? lines
              : lines.where((l) => _lineIds.contains(l.id)).toList(),
        ),
      ),
    );
  }

  /// Loads the address book and picks [selectId], else the default.
  Future<void> loadAddress({String? selectId}) async {
    emit(state.copyWith(addressStatus: SectionStatus.loading));
    final result = await _getAddresses.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(addressStatus: SectionStatus.error)),
      (list) {
        final picked =
            list.firstWhereOrNull((a) => a.id == selectId) ??
            list.firstWhereOrNull((a) => a.id == state.address?.id) ??
            list.firstOrNull;
        emit(
          CheckoutState(
            linesStatus: state.linesStatus,
            lines: state.lines,
            addressStatus: SectionStatus.loaded,
            address: picked,
            shippingStatus: state.shippingStatus,
            shippingMethods: state.shippingMethods,
            shippingId: state.shippingId,
            paymentStatus: state.paymentStatus,
            paymentMethods: state.paymentMethods,
            paymentId: state.paymentId,
            voucher: state.voucher,
            voucherStatus: state.voucherStatus,
          ),
        );
      },
    );
  }

  Future<void> loadShipping() async {
    emit(state.copyWith(shippingStatus: SectionStatus.loading));
    final result = await _getShippingMethods.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(shippingStatus: SectionStatus.error)),
      (methods) => emit(
        state.copyWith(
          shippingStatus: SectionStatus.loaded,
          shippingMethods: methods,
          shippingId: state.shippingId ?? methods.firstOrNull?.id,
        ),
      ),
    );
  }

  Future<void> loadPayment() async {
    emit(state.copyWith(paymentStatus: SectionStatus.loading));
    final result = await _getPaymentMethods.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(paymentStatus: SectionStatus.error)),
      (methods) => emit(
        state.copyWith(
          paymentStatus: SectionStatus.loaded,
          paymentMethods: methods,
          paymentId: state.paymentId ?? methods.firstOrNull?.id,
        ),
      ),
    );
  }

  void selectShipping(String id) => emit(state.copyWith(shippingId: id));

  void selectPayment(String id) => emit(state.copyWith(paymentId: id));

  Future<void> applyVoucher(String code) async {
    emit(state.copyWith(voucherStatus: VoucherStatus.applying));
    final result = await _applyVoucher.call(code);
    result.fold(
      (_) => emit(
        state.copyWith(
          clearVoucher: true,
          voucherStatus: VoucherStatus.invalid,
        ),
      ),
      (voucher) => emit(
        state.copyWith(voucher: voucher, voucherStatus: VoucherStatus.idle),
      ),
    );
  }

  /// Typing a new code hides the previous "invalid" message.
  void clearVoucherError() {
    if (state.voucherStatus == VoucherStatus.invalid) {
      emit(state.copyWith(voucherStatus: VoucherStatus.idle));
    }
  }

  void removeVoucher() => emit(
    state.copyWith(clearVoucher: true, voucherStatus: VoucherStatus.idle),
  );

  Future<void> placeOrder() async {
    if (!state.canPlace) return;
    final totals = state.totals;
    final shipping = state.shipping!;
    final address = state.address!;
    emit(state.copyWith(isPlacing: true));

    final result = await _placeOrder.call(
      NewOrder(
        items: [
          for (final l in state.lines)
            OrderItem(
              productId: l.productId,
              name: l.name,
              imageUrl: l.imageUrl,
              colorName: l.colorName,
              size: l.size,
              unitPrice: l.unitPrice,
              quantity: l.quantity,
            ),
        ],
        shipTo: ShipTo(
          fullName: address.fullName,
          phone: address.phone,
          address: address.singleLine,
        ),
        shippingMethod: shipping.name,
        shippingFee: totals.shippingFee,
        deliveryDays: shipping.maxDays,
        paymentMethod: state.payment!.name,
        subtotal: totals.subtotal,
        discount: totals.discount,
        total: totals.total,
        voucherCode: state.voucher?.code,
      ),
    );

    await result.fold(
      (_) async => emit(
        state.copyWith(
          isPlacing: false,
          placeFailures: state.placeFailures + 1,
        ),
      ),
      (order) async {
        // Show success as soon as the order exists; tidying the cart and
        // notifying are best effort and never undo it.
        emit(state.copyWith(isPlacing: false, placedOrder: order));
        await Future.wait([
          _removeCartLines.call(state.lines.map((l) => l.id).toSet()),
          _addNotification.call(
            NewNotification(
              title: 'Order placed',
              body:
                  'We received order #${order.id}. We will let you know '
                  'when it ships.',
              type: NotificationType.orderUpdate,
              relatedItemId: order.id,
            ),
          ),
        ]);
      },
    );
  }
}
