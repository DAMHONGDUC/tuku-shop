import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/data/mock/checkout_mock.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/presentation/checkout/checkout_controller.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

class _GetCart extends Mock implements GetCartUsecase {}

class _GetAddresses extends Mock implements GetAddressesUsecase {}

class _GetShipping extends Mock implements GetShippingMethodsUsecase {}

class _GetPayment extends Mock implements GetPaymentMethodsUsecase {}

class _ApplyVoucher extends Mock implements ApplyVoucherUsecase {}

class _PlaceOrder extends Mock implements PlaceOrderUsecase {}

class _RemoveLines extends Mock implements RemoveCartLinesUsecase {}

class _AddNotification extends Mock implements AddNotificationUsecase {}

void main() {
  late _GetCart getCart;
  late _ApplyVoucher applyVoucher;
  late _PlaceOrder placeOrder;
  late _RemoveLines removeLines;
  late _AddNotification addNotification;
  late CheckoutController controller;

  CartLine line(String id, double price) => CartLine(
    productId: id,
    name: id,
    brand: 'b',
    imageUrl: 'a.jpg',
    colorName: 'Black',
    size: 'M',
    unitPrice: price,
    quantity: 1,
    maxQuantity: 5,
  );

  final dress = line('wd1', 69);
  final tee = line('mt1', 20);
  const home = AddressEntity(
    id: 'addr-home',
    label: 'Home',
    fullName: 'Tuku Demo',
    phone: '1',
    street: 'Market',
    city: 'SF',
    state: 'CA',
    postalCode: '94103',
    isDefault: true,
  );

  setUpAll(() {
    registerFallbackValue(
      const NewOrder(
        items: [],
        shipTo: ShipTo(fullName: '', phone: '', address: ''),
        shippingMethod: '',
        shippingFee: 0,
        deliveryDays: 0,
        paymentMethod: '',
        subtotal: 0,
        discount: 0,
        total: 0,
      ),
    );
    registerFallbackValue(
      const NewNotification(
        title: '',
        body: '',
        type: NotificationType.general,
      ),
    );
    registerFallbackValue(<String>{});
  });

  setUp(() {
    getCart = _GetCart();
    final getAddresses = _GetAddresses();
    final getShipping = _GetShipping();
    final getPayment = _GetPayment();
    applyVoucher = _ApplyVoucher();
    placeOrder = _PlaceOrder();
    removeLines = _RemoveLines();
    addNotification = _AddNotification();

    when(
      () => getCart.call(NoParams()),
    ).thenAnswer((_) async => Right([dress, tee]));
    when(
      () => getAddresses.call(NoParams()),
    ).thenAnswer((_) async => const Right([home]));
    when(
      () => getShipping.call(NoParams()),
    ).thenAnswer((_) async => const Right(CheckoutMock.shippingMethods));
    when(
      () => getPayment.call(NoParams()),
    ).thenAnswer((_) async => const Right(CheckoutMock.paymentMethods));

    controller = CheckoutController(
      getCart: getCart,
      getAddresses: getAddresses,
      getShippingMethods: getShipping,
      getPaymentMethods: getPayment,
      applyVoucher: applyVoucher,
      placeOrder: placeOrder,
      removeCartLines: removeLines,
      addNotification: addNotification,
    );
  });

  tearDown(() => controller.close());

  test('init loads every section and picks defaults', () async {
    await controller.init();
    final s = controller.state;
    expect(s.lines, [dress, tee]);
    expect(s.address, home);
    expect(s.shippingId, 'standard');
    expect(s.paymentId, 'cod');
    expect(s.totals.total, 93.99);
    expect(s.canPlace, isTrue);
  });

  test('Buy now checks out only the given line', () async {
    await controller.init(lineIds: {dress.id});
    expect(controller.state.lines, [dress]);
  });

  test('an invalid voucher is flagged and clears any discount', () async {
    when(
      () => applyVoucher.call('NOPE'),
    ).thenAnswer((_) async => const Left(ValidationFailure('invalid_voucher')));
    await controller.init();
    await controller.applyVoucher('NOPE');
    expect(controller.state.voucherStatus, VoucherStatus.invalid);
    expect(controller.state.totals.discount, 0);

    controller.clearVoucherError();
    expect(controller.state.voucherStatus, VoucherStatus.idle);
  });

  test('placing removes the ordered lines and raises a notification', () async {
    final order = OrderEntity(
      id: 'TK100013',
      createdAt: DateTime(2026),
      status: OrderStatus.waitingForConfirmation,
      items: const [],
      shipTo: const ShipTo(fullName: '', phone: '', address: ''),
      shippingMethod: 'Standard',
      shippingFee: 0,
      paymentMethod: 'Cash on delivery',
      subtotal: 89,
      discount: 0,
      total: 93.99,
      estimatedDelivery: DateTime(2026),
      events: const [],
    );
    when(() => placeOrder.call(any())).thenAnswer((_) async => Right(order));
    when(
      () => removeLines.call(any()),
    ).thenAnswer((_) async => const Right([]));
    when(
      () => addNotification.call(any()),
    ).thenAnswer((_) async => const Right(unit));

    await controller.init();
    await controller.placeOrder();

    expect(controller.state.placedOrder, order);
    verify(() => removeLines.call({dress.id, tee.id})).called(1);
    final placed =
        verify(() => placeOrder.call(captureAny())).captured.single as NewOrder;
    expect(placed.total, 93.99);
    expect(placed.shipTo.fullName, 'Tuku Demo');
    verify(() => addNotification.call(any())).called(1);
  });
}
