import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/wishlist/data/data_sources/wishlist_local_data_source.dart';
import 'package:tuku_shop/src/features/wishlist/data/mock/wishlist_mock.dart';
import 'package:tuku_shop/src/features/wishlist/data/repositories/wishlist_repository_impl.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  T run<T>(Future<T> Function() body) {
    late T result;
    fakeAsync((async) {
      body().then((value) => result = value);
      async.elapse(MockLatency.duration * 4);
    });
    return result;
  }

  test('first launch seeds the demo wishlist', () {
    final repo = WishlistRepositoryImpl(
      dataSource: WishlistLocalDataSourceImpl(),
    );
    final ids = run(repo.getIds).getOrElse(() => throw 'Left');
    expect(ids, WishlistMock.seedIds);
  });

  test('toggle adds to the front, removes, and survives a relaunch', () {
    final repo = WishlistRepositoryImpl(
      dataSource: WishlistLocalDataSourceImpl(),
    );
    final emitted = <List<String>>[];
    repo.watchIds().listen(emitted.add);

    expect(run(() => repo.toggle('mt1')).getOrElse(() => throw 'Left'), isTrue);
    expect(
      run(() => repo.toggle('wd1')).getOrElse(() => throw 'Left'),
      isFalse,
    );

    final relaunched = WishlistRepositoryImpl(
      dataSource: WishlistLocalDataSourceImpl(),
    );
    final ids = run(relaunched.getIds).getOrElse(() => throw 'Left');
    expect(ids.first, 'mt1');
    expect(ids, isNot(contains('wd1')));
    expect(emitted.length, 2);
  });
}
