import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/presentation/cart/cart_controller.dart';

import '../../../helpers/mock_usecases.dart';

void main() {
  late MockGetCartUsecase get;
  late MockWatchCartUsecase watch;
  late MockUpdateCartQuantityUsecase update;
  late MockRemoveCartLineUsecase remove;
  late MockAddToCartUsecase add;
  late StreamController<List<CartLine>> changes;

  const line = CartLine(
    productId: 'mt1',
    name: 'Tee',
    brand: 'b',
    imageUrl: 'a.jpg',
    colorName: 'White',
    size: 'M',
    unitPrice: 20,
    quantity: 1,
    maxQuantity: 3,
  );

  setUpAll(() {
    registerFallbackValue(
      const UpdateCartQuantityParams(lineId: '', quantity: 1),
    );
    registerFallbackValue(line);
  });

  setUp(() {
    get = MockGetCartUsecase();
    watch = MockWatchCartUsecase();
    update = MockUpdateCartQuantityUsecase();
    remove = MockRemoveCartLineUsecase();
    add = MockAddToCartUsecase();
    changes = StreamController.broadcast();
    when(() => watch()).thenAnswer((_) => changes.stream);
    when(
      () => get.call(NoParams()),
    ).thenAnswer((_) async => const Right([line]));
  });

  tearDown(() => changes.close());

  Future<CartController> loaded() async {
    final c = CartController(get, watch, update, remove, add);
    await c.load();
    return c;
  }

  test('quantity changes show at once', () async {
    when(
      () => update.call(any()),
    ).thenAnswer((_) async => Right([line.copyWith(quantity: 2)]));
    final c = await loaded();
    final pending = c.changeQuantity(line.id, 2);
    expect(c.state.lines.single.quantity, 2);
    await pending;
    expect(c.state.itemCount, 2);
  });

  test('a quantity above stock is ignored', () async {
    final c = await loaded();
    await c.changeQuantity(line.id, 4);
    verifyNever(() => update.call(any()));
  });

  test('a failed change rolls back and counts the failure', () async {
    when(
      () => update.call(any()),
    ).thenAnswer((_) async => Left(CacheFailure()));
    final c = await loaded();
    await c.changeQuantity(line.id, 2);
    expect(c.state.lines.single.quantity, 1);
    expect(c.state.failureCount, 1);
  });

  test('remove then undo puts the line back', () async {
    when(() => remove.call(line.id)).thenAnswer((_) async => const Right([]));
    when(() => add.call(any())).thenAnswer((_) async => const Right([line]));
    final c = await loaded();
    final removed = await c.remove(line.id);
    expect(c.state.lines, isEmpty);
    await c.undoRemove(removed!);
    expect(c.state.lines, [line]);
  });
}
