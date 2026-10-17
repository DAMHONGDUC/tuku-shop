import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/app/state/cart_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:tuku_shop/src/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

/// The bag controller over the real in-memory repository, so the states are
/// the ones the tab bar badge and the Bag tab actually see.
void main() {
  late CartRepository repository;

  const AddToCartParams tee = AddToCartParams(
    productId: 'p_1',
    name: 'Tee',
    brand: 'Tuku',
    image: 'tee.webp',
    color: 'Black',
    size: 'M',
    unitPrice: 50,
  );

  setUpAll(() => MockLatency.enabled = false);

  setUp(
    () => repository = CartRepositoryImpl(
      remote: const CartRemoteDataSourceImpl(),
    ),
  );

  CartController build() => CartController(
    watchCart: WatchCartUsecase(repository),
    addToCart: AddToCartUsecase(repository),
    updateQuantity: UpdateCartQuantityUsecase(repository),
    removeItem: RemoveCartItemUsecase(repository),
    applyPromo: ApplyPromoUsecase(repository),
    removePromo: RemovePromoUsecase(repository),
    clearCart: ClearCartUsecase(repository),
  );

  Future<void> settle() => pumpEventQueue();

  blocTest<CartController, CartEntity>(
    'adding the same item twice raises its quantity',
    build: build,
    act: (CartController c) async {
      await settle();
      await c.add(tee);
      await c.add(tee);
    },
    verify: (CartController c) {
      expect(c.state.items, hasLength(1));
      expect(c.state.itemCount, 2);
    },
  );

  blocTest<CartController, CartEntity>(
    'applyPromo returns null on success and the failure otherwise',
    build: build,
    act: (CartController c) async {
      await settle();
      await c.add(tee);
      expect(
        await c.applyPromo('NOPE'),
        const ValidationFailure(FailureCodes.invalidPromo),
      );
      expect(await c.applyPromo('TUKU10'), isNull);
      await settle();
    },
    verify: (CartController c) => expect(c.state.discount, 5),
  );

  blocTest<CartController, CartEntity>(
    'remove and clear empty the bag',
    build: build,
    act: (CartController c) async {
      await settle();
      await c.add(tee);
      await c.updateQuantity('p_1|Black|M', 3);
      await settle();
      expect(c.state.itemCount, 3);
      await c.remove('p_1|Black|M');
      await c.add(tee);
      await c.clear();
      await settle();
    },
    verify: (CartController c) => expect(c.state.isEmpty, isTrue),
  );
}
