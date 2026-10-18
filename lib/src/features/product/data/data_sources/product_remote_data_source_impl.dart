import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/mock/product_mock.dart';
import 'package:tuku_shop/src/features/product/data/mock/search_mock.dart';
import 'package:tuku_shop/src/features/product/data/models/product_data_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/reviews_page_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl();

  List<ProductModel> get _all => ProductMock.products;

  /// A stable pseudo-random rank, so "Recommended" mixes categories the same
  /// way on every launch.
  static int _rank(String id) =>
      id.codeUnits.fold(17, (h, c) => (h * 31 + c) % 1000003);

  @override
  Future<ProductsDataModel> getProducts(ProductQuery query) async {
    try {
      await MockLatency.wait();

      final keyword = query.keyword.trim().toLowerCase();
      final matched = _all.where((p) {
        if (query.categoryId != null && p.categoryId != query.categoryId) {
          return false;
        }
        if (query.tag != null && !(p.tags ?? []).contains(query.tag!.name)) {
          return false;
        }
        if (query.onSaleOnly && p.originalPrice == null) return false;
        if (keyword.isEmpty) return true;
        final haystack = [
          p.name,
          p.brand,
          p.categoryId?.replaceAll('-', ' '),
          ...?p.productColors?.map((c) => c.colorName),
        ].whereType<String>().join(' ').toLowerCase();
        return keyword.split(' ').every(haystack.contains);
      }).toList();

      switch (query.sort) {
        case ProductSort.recommended:
          matched.sort((a, b) => _rank(a.id!).compareTo(_rank(b.id!)));
        case ProductSort.newest:
          matched.sort((a, b) {
            final aNew = (a.tags ?? []).contains(ProductTag.newArrival.name);
            final bNew = (b.tags ?? []).contains(ProductTag.newArrival.name);
            if (aNew != bNew) return aNew ? -1 : 1;
            return _all.indexOf(b).compareTo(_all.indexOf(a));
          });
        case ProductSort.priceLowToHigh:
          matched.sort((a, b) => a.price!.compareTo(b.price!));
        case ProductSort.priceHighToLow:
          matched.sort((a, b) => b.price!.compareTo(a.price!));
        case ProductSort.rating:
          matched.sort((a, b) => b.averageRating!.compareTo(a.averageRating!));
      }

      final total = matched.length;
      final start = (query.page - 1) * query.pageSize;
      final end = (start + query.pageSize).clamp(0, total);

      return ProductsDataModel(
        items: start < total ? matched.sublist(start, end) : const [],
        totalPage: total == 0 ? 0 : (total / query.pageSize).ceil(),
        currentPage: query.page,
        totalRecord: total,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductDetail({required String productId}) async {
    await MockLatency.wait();
    final product = _all.firstWhereOrNull((e) => e.id == productId);
    if (product == null) throw const ServerException('Product not found');
    return product;
  }

  @override
  Future<List<ProductModel>> getRelatedProducts({
    required String productId,
    int? limit,
  }) async {
    try {
      await MockLatency.wait();
      final product = _all.firstWhereOrNull((e) => e.id == productId);
      // Same category first, then the rest, so the strip is never short.
      final others =
          _all
              .where(
                (e) => e.id != productId && e.categoryId != product?.categoryId,
              )
              .toList()
            ..sort((a, b) => _rank(a.id!).compareTo(_rank(b.id!)));
      final related = [
        ..._all.where(
          (e) => e.id != productId && e.categoryId == product?.categoryId,
        ),
        ...others,
      ];
      return limit == null ? related : related.take(limit).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsByIds(List<String> ids) async {
    try {
      await MockLatency.wait();
      return [for (final id in ids) ?_all.firstWhereOrNull((e) => e.id == id)];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReviewsPageModel> getProductReviews({
    required String productId,
    required int page,
    required int pageSize,
  }) async {
    await MockLatency.wait();
    final product = _all.firstWhereOrNull((e) => e.id == productId);
    if (product == null) throw const ServerException('Product not found');

    final reviews = product.reviewComments ?? const [];
    final total = reviews.length;
    final start = (page - 1) * pageSize;
    final end = (start + pageSize).clamp(0, total);

    return ReviewsPageModel(
      items: start < total ? reviews.sublist(start, end) : const [],
      currentPage: page,
      totalPage: total == 0 ? 0 : (total / pageSize).ceil(),
      totalRecord: total,
    );
  }

  @override
  Future<List<String>> getTrendingSearches() async {
    await MockLatency.wait();
    return SearchMock.trending;
  }
}
