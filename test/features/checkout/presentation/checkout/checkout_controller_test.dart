import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/presentation/checkout/checkout_controller.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetAddressesUsecase getAddresses;
  late MockGetPaymentMethodsUsecase getPaymentMethods;
  late MockGetDeliveryOptionsUsecase getDeliveryOptions;
  late MockPlaceOrderUsecase placeOrder;
  late MockClearCartUsecase clearCart;

  final CartEntity cart = CartEntity(
    items: <CartItemEntity>[Fixtures.cartItem(unitPrice: 20, quantity: 2)],
  );

  const CheckoutState loaded = CheckoutState(
    status: LoadStatus.success,
    addresses: <AddressEntity>[Fixtures.otherAddress, Fixtures.address],
    payments: <PaymentMethodEntity>[Fixtures.card],
    deliveryOptions: <DeliveryOptionEntity>[Fixtures.standard],
    addressId: 'a_1',
    paymentId: 'pm_1',
    deliveryId: 'standard',
  );

  setUpAll(() {
    registerFallbackValue(
      const PlaceOrderParams(
        items: <OrderItemEntity>[],
        recipient: '',
        phone: '',
        address: '',
        paymentType: PaymentMethodType.card,
        paymentLabel: '',
        deliveryOptionId: '',
        deliveryMaxDays: 0,
        subtotal: 0,
        shippingFee: 0,
        discount: 0,
      ),
    );
  });

  setUp(() {
    getAddresses = MockGetAddressesUsecase();
    getPaymentMethods = MockGetPaymentMethodsUsecase();
    getDeliveryOptions = MockGetDeliveryOptionsUsecase();
    placeOrder = MockPlaceOrderUsecase();
    clearCart = MockClearCartUsecase();

    when(() => getAddresses(const NoParams())).thenAnswer(
      (_) async => Right<Failure, List<AddressEntity>>(loaded.addresses),
    );
    when(() => getPaymentMethods(const NoParams())).thenAnswer(
      (_) async => Right<Failure, List<PaymentMethodEntity>>(loaded.payments),
    );
    when(() => getDeliveryOptions(const NoParams())).thenAnswer(
      (_) async =>
          Right<Failure, List<DeliveryOptionEntity>>(loaded.deliveryOptions),
    );
    when(
      () => clearCart(const NoParams()),
    ).thenAnswer((_) async => const Right<Failure, CartEntity>(CartEntity()));
  });

  CheckoutController build() => CheckoutController(
    getAddresses: getAddresses,
    getPaymentMethods: getPaymentMethods,
    getDeliveryOptions: getDeliveryOptions,
    placeOrder: placeOrder,
    clearCart: clearCart,
  );

  blocTest<CheckoutController, CheckoutState>(
    'load picks the default address and payment and the first delivery option',
    build: build,
    act: (CheckoutController c) => c.load(),
    expect: () => <CheckoutState>[const CheckoutState(), loaded],
  );

  blocTest<CheckoutController, CheckoutState>(
    'load fails when any part fails',
    build: () {
      when(() => getPaymentMethods(const NoParams())).thenAnswer(
        (_) async =>
            const Left<Failure, List<PaymentMethodEntity>>(ServerFailure()),
      );
      return build();
    },
    act: (CheckoutController c) => c.load(),
    expect: () => <CheckoutState>[
      const CheckoutState(),
      const CheckoutState(status: LoadStatus.failure),
    ],
  );

  blocTest<CheckoutController, CheckoutState>(
    'placeOrder sends the bag, clears it and records the order',
    build: () {
      when(() => placeOrder(any())).thenAnswer(
        (_) async => Right<Failure, OrderEntity>(Fixtures.order(id: 'o_9')),
      );
      return build();
    },
    seed: () => loaded,
    act: (CheckoutController c) => c.placeOrder(cart),
    expect: () => <CheckoutState>[
      loaded.copyWith(placing: true),
      loaded.copyWith(placedOrderId: 'o_9'),
    ],
    verify: (_) {
      final PlaceOrderParams sent =
          verify(() => placeOrder(captureAny())).captured.single
              as PlaceOrderParams;
      expect(sent.subtotal, 40);
      expect(sent.shippingFee, Fixtures.standard.fee);
      expect(sent.address, Fixtures.address.oneLine);
      expect(sent.items.single.quantity, 2);
      verify(() => clearCart(const NoParams())).called(1);
    },
  );

  blocTest<CheckoutController, CheckoutState>(
    'a failed order keeps the bag and shows the failure',
    build: () {
      when(() => placeOrder(any())).thenAnswer(
        (_) async => const Left<Failure, OrderEntity>(ServerFailure()),
      );
      return build();
    },
    seed: () => loaded,
    act: (CheckoutController c) => c.placeOrder(cart),
    expect: () => <CheckoutState>[
      loaded.copyWith(placing: true),
      loaded.copyWith(failure: () => const ServerFailure()),
    ],
    verify: (_) => verifyNever(() => clearCart(const NoParams())),
  );

  blocTest<CheckoutController, CheckoutState>(
    'nothing is placed without an address',
    build: build,
    seed: () => const CheckoutState(status: LoadStatus.success),
    act: (CheckoutController c) => c.placeOrder(cart),
    expect: () => <CheckoutState>[],
    verify: (_) => verifyNever(() => placeOrder(any())),
  );

  test('shippingFor is free over the threshold with the standard option', () {
    final CheckoutController controller = build()..emit(loaded);
    final CartEntity big = CartEntity(
      items: <CartItemEntity>[
        Fixtures.cartItem(unitPrice: AppConstants.freeShippingThreshold),
      ],
    );

    expect(controller.shippingFor(big), 0);
    expect(controller.shippingFor(cart), Fixtures.standard.fee);
  });
}
