import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/mock/product_mock.dart';
import 'package:tuku_shop/src/features/seller/data/data_sources/seller_remote_data_source.dart';
import 'package:tuku_shop/src/features/seller/data/mock/seller_mock.dart';
import 'package:tuku_shop/src/features/seller/data/repositories/seller_repository_impl.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

void main() {
  const repo = SellerRepositoryImpl(dataSource: SellerRemoteDataSourceImpl());

  T run<T>(Future<T> Function() body) {
    late T result;
    fakeAsync((async) {
      body().then((value) => result = value);
      async.elapse(MockLatency.max);
    });
    return result;
  }

  test('every product is sold by a known shop, and every shop sells', () {
    final shopIds = SellerMock.sellers.map((s) => s.id).toSet();
    final used = ProductMock.products.map((p) => p.sellerId).toSet();
    expect(shopIds.containsAll(used), isTrue);
    expect(used, shopIds);
  });

  test('a brand with a reseller is split between both shops', () {
    final aurora = ProductMock.products
        .where((p) => p.brand == 'Aurora')
        .map((p) => p.sellerId)
        .toSet();
    expect(aurora, {'aurora-official', 'saigon-closet'});
  });

  test('sellers by ids keep the order and skip unknown ids', () {
    final sellers = run(
      () => repo.getSellersByIds(['tuku-studio', 'nope', 'denim-house']),
    ).getOrElse(() => []);
    expect(sellers.map((s) => s.id), ['tuku-studio', 'denim-house']);
  });

  test('an unknown seller is a failure', () {
    expect(run(() => repo.getSeller('nope')).isLeft(), isTrue);
  });

  test('initials take the first letters of two words', () {
    const seller = Seller(
      id: 'x',
      name: 'Aurora Official Store',
      colorHex: '#000000',
      rating: 5,
      followerCount: 1,
      responseRate: 100,
      location: '',
    );
    expect(seller.initials, 'AO');
  });
}
