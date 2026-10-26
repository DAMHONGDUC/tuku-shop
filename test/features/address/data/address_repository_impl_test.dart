import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/data/data_sources/address_local_data_source.dart';
import 'package:tuku_shop/src/features/address/data/repositories/address_repository_impl.dart';

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

  AddressRepositoryImpl repo() =>
      AddressRepositoryImpl(dataSource: AddressLocalDataSourceImpl());

  test('the seeded default comes first', () {
    final list = run(repo().getAddresses).getOrElse(() => throw 'L');
    expect(list.first.id, 'addr-home');
    expect(list.where((a) => a.isDefault).length, 1);
  });

  test('setting a new default keeps exactly one', () {
    final r = repo();
    run(() => r.setDefault('addr-office'));
    final list = run(r.getAddresses).getOrElse(() => throw 'L');
    expect(list.first.id, 'addr-office');
    expect(list.where((a) => a.isDefault).length, 1);
  });

  test('deleting the default promotes another', () {
    final r = repo();
    run(() => r.delete('addr-home'));
    final list = run(r.getAddresses).getOrElse(() => throw 'L');
    expect(list.single.id, 'addr-office');
    expect(list.single.isDefault, isTrue);
  });
}
