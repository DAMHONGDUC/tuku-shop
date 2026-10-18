part of 'checkout_controller.dart';

enum SectionStatus { loading, loaded, error }

enum VoucherStatus { idle, applying, invalid }

class CheckoutState extends Equatable {
  final SectionStatus linesStatus;
  final List<CartLine> lines;
  final SectionStatus addressStatus;
  final AddressEntity? address;
  final SectionStatus shippingStatus;
  final List<ShippingMethod> shippingMethods;
  final String? shippingId;
  final SectionStatus paymentStatus;
  final List<PaymentMethod> paymentMethods;
  final String? paymentId;
  final Voucher? voucher;
  final VoucherStatus voucherStatus;
  final bool isPlacing;
  final OrderEntity? placedOrder;
  final int placeFailures;

  const CheckoutState({
    this.linesStatus = SectionStatus.loading,
    this.lines = const [],
    this.addressStatus = SectionStatus.loading,
    this.address,
    this.shippingStatus = SectionStatus.loading,
    this.shippingMethods = const [],
    this.shippingId,
    this.paymentStatus = SectionStatus.loading,
    this.paymentMethods = const [],
    this.paymentId,
    this.voucher,
    this.voucherStatus = VoucherStatus.idle,
    this.isPlacing = false,
    this.placedOrder,
    this.placeFailures = 0,
  });

  ShippingMethod? get shipping =>
      shippingMethods.where((m) => m.id == shippingId).firstOrNull;

  PaymentMethod? get payment =>
      paymentMethods.where((m) => m.id == paymentId).firstOrNull;

  double get subtotal => CartSummary(lines).subtotal;

  CheckoutTotals get totals => CheckoutTotals.compute(
    subtotal: subtotal,
    shipping: shipping,
    voucher: voucher,
  );

  bool get canPlace =>
      !isPlacing &&
      lines.isNotEmpty &&
      address != null &&
      shipping != null &&
      payment != null;

  CheckoutState copyWith({
    SectionStatus? linesStatus,
    List<CartLine>? lines,
    SectionStatus? addressStatus,
    AddressEntity? address,
    SectionStatus? shippingStatus,
    List<ShippingMethod>? shippingMethods,
    String? shippingId,
    SectionStatus? paymentStatus,
    List<PaymentMethod>? paymentMethods,
    String? paymentId,
    Voucher? voucher,
    bool clearVoucher = false,
    VoucherStatus? voucherStatus,
    bool? isPlacing,
    OrderEntity? placedOrder,
    int? placeFailures,
  }) {
    return CheckoutState(
      linesStatus: linesStatus ?? this.linesStatus,
      lines: lines ?? this.lines,
      addressStatus: addressStatus ?? this.addressStatus,
      address: address ?? this.address,
      shippingStatus: shippingStatus ?? this.shippingStatus,
      shippingMethods: shippingMethods ?? this.shippingMethods,
      shippingId: shippingId ?? this.shippingId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      paymentId: paymentId ?? this.paymentId,
      voucher: clearVoucher ? null : (voucher ?? this.voucher),
      voucherStatus: voucherStatus ?? this.voucherStatus,
      isPlacing: isPlacing ?? this.isPlacing,
      placedOrder: placedOrder ?? this.placedOrder,
      placeFailures: placeFailures ?? this.placeFailures,
    );
  }

  @override
  List<Object?> get props => [
    linesStatus,
    lines,
    addressStatus,
    address,
    shippingStatus,
    shippingMethods,
    shippingId,
    paymentStatus,
    paymentMethods,
    paymentId,
    voucher,
    voucherStatus,
    isPlacing,
    placedOrder,
    placeFailures,
  ];
}
