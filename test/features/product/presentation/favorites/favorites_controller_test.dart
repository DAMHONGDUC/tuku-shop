import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorites_controller.dart';

import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetWishlistIdsUsecase getIds;
  late MockWatchWishlistIdsUsecase watchIds;
  late MockToggleWishlistUsecase toggle;
  late StreamController<List<String>> changes;

  setUp(() {
    getIds = MockGetWishlistIdsUsecase();
    watchIds = MockWatchWishlistIdsUsecase();
    toggle = MockToggleWishlistUsecase();
    changes = StreamController<List<String>>.broadcast();
    when(() => watchIds()).thenAnswer((_) => changes.stream);
    when(
      () => getIds.call(NoParams()),
    ).thenAnswer((_) async => const Right(['a']));
  });

  tearDown(() => changes.close());

  FavoritesController build() => FavoritesController(getIds, watchIds, toggle);

  test('load fills the saved ids', () async {
    final c = build();
    await c.load();
    expect(c.state.ids, {'a'});
  });

  test('toggle shows at once and keeps it on success', () async {
    when(() => toggle.call('b')).thenAnswer((_) async => const Right(true));
    final c = build();
    await c.load();
    final pending = c.toggle('b');
    expect(c.state.ids, {'a', 'b'});
    await pending;
    expect(c.state.ids, {'a', 'b'});
  });

  test('toggle rolls back and counts the failure', () async {
    when(() => toggle.call('a')).thenAnswer((_) async => Left(CacheFailure()));
    final c = build();
    await c.load();
    await c.toggle('a');
    expect(c.state.ids, {'a'});
    expect(c.state.failureCount, 1);
  });

  test('follows changes made elsewhere', () async {
    final c = build();
    changes.add(['x', 'y']);
    await Future<void>.delayed(Duration.zero);
    expect(c.state.ids, {'x', 'y'});
  });
}
