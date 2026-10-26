import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/favorites_preview/favorites_preview_controller.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mock_usecases.dart';

void main() {
  late MockGetWishlistIdsUsecase getIds;
  late MockWatchWishlistIdsUsecase watchIds;
  late MockGetProductsByIdsUsecase getProducts;
  late StreamController<List<String>> changes;

  final ids = [for (var i = 0; i < 8; i++) 'p$i'];

  setUp(() {
    getIds = MockGetWishlistIdsUsecase();
    watchIds = MockWatchWishlistIdsUsecase();
    getProducts = MockGetProductsByIdsUsecase();
    changes = StreamController<List<String>>.broadcast();
    when(() => watchIds()).thenAnswer((_) => changes.stream);
    when(() => getIds.call(NoParams())).thenAnswer((_) async => Right(ids));
    when(() => getProducts.call(any())).thenAnswer(
      (i) async => Right([
        for (final id in i.positionalArguments.first as List<String>)
          tProduct(id: id),
      ]),
    );
  });

  tearDown(() => changes.close());

  FavoritesPreviewController build() =>
      FavoritesPreviewController(getIds, watchIds, getProducts);

  blocTest<FavoritesPreviewController, FavoritesPreviewState>(
    'load shows the first six products and the full count',
    build: build,
    act: (c) => c.load(),
    expect: () => [
      const FavoritesPreviewState(),
      FavoritesPreviewState(
        status: FavoritesPreviewStatus.loaded,
        products: [for (final id in ids.take(6)) tProduct(id: id)],
        total: 8,
      ),
    ],
    verify: (_) =>
        verify(() => getProducts.call(ids.take(6).toList())).called(1),
  );

  blocTest<FavoritesPreviewController, FavoritesPreviewState>(
    'load fails to the error state',
    build: build,
    setUp: () => when(
      () => getIds.call(NoParams()),
    ).thenAnswer((_) async => Left(CacheFailure())),
    act: (c) => c.load(),
    expect: () => [
      const FavoritesPreviewState(),
      const FavoritesPreviewState(status: FavoritesPreviewStatus.error),
    ],
  );

  test('a removal elsewhere updates the card without a fetch', () async {
    final c = build();
    await c.load();
    clearInteractions(getProducts);

    changes.add(['p1', 'p2']);
    await Future<void>.delayed(Duration.zero);

    expect(c.state.products.map((p) => p.id), ['p1', 'p2']);
    expect(c.state.total, 2);
    verifyNever(() => getProducts.call(any()));
    await c.close();
  });
}
