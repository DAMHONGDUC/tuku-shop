import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/features/banner/data/mock/banner_mock.dart';
import 'package:tuku_shop/src/features/category/data/mock/category_mock.dart';
import 'package:tuku_shop/src/features/order/data/mock/order_mock.dart';
import 'package:tuku_shop/src/features/product/data/mock/product_mock.dart';

/// Every asset a mock points at must exist and be declared in pubspec, or the
/// demo shows a broken image.
void main() {
  final pubspec = File('pubspec.yaml').readAsStringSync();

  void expectAsset(String path) {
    expect(File(path).existsSync(), isTrue, reason: 'missing file $path');
    final dir = path.substring(0, path.lastIndexOf('/') + 1);
    expect(pubspec.contains('- $dir'), isTrue, reason: '$dir not in pubspec');
  }

  test('product images exist', () {
    for (final product in ProductMock.products) {
      for (final image in product.images!) {
        expectAsset(image);
      }
      for (final color in product.productColors!) {
        expectAsset(color.imageUrl!);
      }
    }
  });

  test('category, banner and order images exist', () {
    CategoryMock.categories.map((e) => e.imageUrl!).forEach(expectAsset);
    BannerMock.banners.map((e) => e.imageUrl!).forEach(expectAsset);
    OrderMock.generateOrders(
      count: 20,
    ).map((e) => e.productThumbnailUrl!).forEach(expectAsset);
  });

  test('category product counts match the catalog', () {
    for (final category in CategoryMock.categories) {
      final count = ProductMock.products
          .where((p) => p.categoryId == category.id)
          .length;
      expect(count, category.numOfProduct, reason: category.id);
    }
  });

  test('product ids are unique and order snapshots point at real products', () {
    final ids = ProductMock.products.map((e) => e.id).toSet();
    expect(ids.length, ProductMock.products.length);
    for (final order in OrderMock.generateOrders(count: 20)) {
      expect(ids, contains(order.productId));
    }
  });

  test('every product has stock in at least one variant', () {
    for (final product in ProductMock.products) {
      expect(
        product.variants!.any((v) => (v.stock ?? 0) > 0),
        isTrue,
        reason: product.id,
      );
    }
  });
}
