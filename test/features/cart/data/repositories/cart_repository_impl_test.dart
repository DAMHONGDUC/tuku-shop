import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:tuku_shop/src/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

import '../../../../helpers/fixtures.dart';

void main() {
  late CartRepositoryImpl repository;

  setUpAll(() => MockLatency.enabled = false);

  setUp(() {
    repository = CartRepositoryImpl(remote: const CartRemoteDataSourceImpl());
  });

  CartEntity right(Either<Failure, CartEntity> result) =>
      result.getOrElse(() => throw StateError('expected Right, got $result'));

  group('add', () {
    test('the same product, colour and size merges into one line', () async {
      await repository.add(Fixtures.cartItem(quantity: 1));
      final CartEntity cart = right(
        await repository.add(Fixtures.cartItem(quantity: 2)),
      );

      expect(cart.items, hasLength(1));
      expect(cart.items.single.quantity, 3);
    });

    test('a different size is a new line, added on top', () async {
      await repository.add(Fixtures.cartItem(size: 'M'));
      final CartEntity cart = right(
        await repository.add(Fixtures.cartItem(size: 'L')),
      );

      expect(cart.items.map((CartItemEntity i) => i.size), <String>['L', 'M']);
    });
  });

  test('updateQuantity changes only that line', () async {
    await repository.add(Fixtures.cartItem());
    await repository.add(Fixtures.cartItem(productId: 'p_2'));

    final CartEntity cart = right(
      await repository.updateQuantity('p_1|Black|M', 4),
    );

    expect(
      cart.items
          .firstWhere((CartItemEntity i) => i.productId == 'p_1')
          .quantity,
      4,
    );
    expect(
      cart.items
          .firstWhere((CartItemEntity i) => i.productId == 'p_2')
          .quantity,
      1,
    );
  });

  test('remove drops the line', () async {
    await repository.add(Fixtures.cartItem());

    final CartEntity cart = right(await repository.remove('p_1|Black|M'));

    expect(cart.isEmpty, isTrue);
  });

  group('applyPromo', () {
    test('a known code is applied', () async {
      await repository.add(Fixtures.cartItem(unitPrice: 50));

      final CartEntity cart = right(await repository.applyPromo('TUKU10'));

      expect(cart.promo?.code, 'TUKU10');
      expect(cart.discount, 5);
    });

    test('an unknown code fails with invalidPromo', () async {
      final Either<Failure, CartEntity> result = await repository.applyPromo(
        'NOPE',
      );

      expect(
        result,
        const Left<Failure, CartEntity>(
          ValidationFailure(FailureCodes.invalidPromo),
        ),
      );
    });

    test('WELCOME20 under its minimum fails with promoMinimum', () async {
      await repository.add(Fixtures.cartItem(unitPrice: 60));

      final Either<Failure, CartEntity> result = await repository.applyPromo(
        'WELCOME20',
      );

      expect(
        result,
        const Left<Failure, CartEntity>(
          ValidationFailure(FailureCodes.promoMinimum),
        ),
      );
    });

    test(
      'the promo falls away when the subtotal drops below its minimum',
      () async {
        await repository.add(Fixtures.cartItem(unitPrice: 60, quantity: 2));
        expect(
          right(await repository.applyPromo('WELCOME20')).promo,
          isNotNull,
        );

        final CartEntity cart = right(
          await repository.updateQuantity('p_1|Black|M', 1),
        );

        expect(cart.promo, isNull);
      },
    );

    test('removePromo clears it', () async {
      await repository.add(Fixtures.cartItem());
      await repository.applyPromo('FREESHIP');

      expect(right(await repository.removePromo()).promo, isNull);
    });
  });

  test('watch replays the current bag, then every change', () async {
    await repository.add(Fixtures.cartItem());

    final Future<List<int>> counts = repository
        .watch()
        .map((CartEntity c) => c.itemCount)
        .take(3)
        .toList();
    // The async* stream subscribes to changes after its first event is delivered.
    await pumpEventQueue();
    await repository.add(Fixtures.cartItem());
    await repository.clear();

    expect(await counts, <int>[1, 2, 0]);
  });
}
