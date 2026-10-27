import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:tuku_shop/src/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  T run<T>(Future<T> Function() body) {
    late T result;
    fakeAsync((async) {
      body().then((value) => result = value);
      async.elapse(MockLatency.max * 4);
    });
    return result;
  }

  CartRepositoryImpl repo() =>
      CartRepositoryImpl(dataSource: CartLocalDataSourceImpl());

  const tee = CartLine(
    productId: 'mt1',
    name: 'Essential Crew Tee',
    brand: 'Tuku Basics',
    imageUrl: 'a.jpg',
    colorName: 'White',
    size: 'M',
    unitPrice: 19.9,
    quantity: 2,
    maxQuantity: 5,
  );

  test('first launch seeds two demo lines', () {
    final lines = run(repo().getLines).getOrElse(() => throw 'Left');
    expect(lines.length, 2);
  });

  test('adding the same variant twice merges and caps at max', () {
    final r = repo();
    run(() => r.add(tee));
    final lines = run(
      () => r.add(tee.copyWith(quantity: 4)),
    ).getOrElse(() => throw 'Left');
    final line = lines.firstWhere((l) => l.id == tee.id);
    expect(line.quantity, 5);
    expect(lines.where((l) => l.id == tee.id).length, 1);
  });

  test('changes survive a relaunch and removeLines drops ordered lines', () {
    final r = repo();
    run(() => r.add(tee));
    run(() => r.updateQuantity(tee.id, 3));

    final relaunched = repo();
    var lines = run(relaunched.getLines).getOrElse(() => throw 'Left');
    expect(lines.firstWhere((l) => l.id == tee.id).quantity, 3);

    lines = run(
      () => relaunched.removeLines({tee.id}),
    ).getOrElse(() => throw 'Left');
    expect(lines.any((l) => l.id == tee.id), isFalse);
  });
}
