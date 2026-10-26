import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/mock/product_mock.dart';
import 'package:tuku_shop/src/features/product/data/mock/search_mock.dart';
import 'package:tuku_shop/src/features/product/data/models/product_data_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_facets_model.dart';
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
        if (query.sellerId != null && p.sellerId != query.sellerId) {
          return false;
        }
        if (query.categoryId != null && p.categoryId != query.categoryId) {
          return false;
        }
        if (query.tag != null && !(p.tags ?? []).contains(query.tag!.name)) {
          return false;
        }
        if (query.onSaleOnly && p.originalPrice == null) return false;
        if (!_matchesFilters(p, query)) return false;
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

  /// Price, rating, stock, size and color filters. A size or color counts
  /// only when some variant of it is in stock.
  static bool _matchesFilters(ProductModel p, ProductQuery query) {
    final price = p.price ?? 0;
    if (query.minPrice != null && price < query.minPrice!) return false;
    if (query.maxPrice != null && price > query.maxPrice!) return false;
    if (query.minRating != null && (p.averageRating ?? 0) < query.minRating!) {
      return false;
    }
    final inStock = (p.variants ?? const []).where((v) => (v.stock ?? 0) > 0);
    if (query.inStockOnly && inStock.isEmpty) return false;
    if (query.sizes.isNotEmpty &&
        !inStock.any((v) => query.sizes.contains(v.size))) {
      return false;
    }
    if (query.colors.isNotEmpty &&
        !inStock.any((v) => query.colors.contains(v.colorName))) {
      return false;
    }
    return true;
  }

  @override
  Future<ProductFacetsModel> getFacets() async {
    try {
      await MockLatency.wait();
      final sizes = <String>[];
      final colors = <String, String>{};
      for (final p in _all) {
        for (final s in p.productSizes ?? const []) {
          if (s.name != null && !sizes.contains(s.name)) sizes.add(s.name!);
        }
        for (final c in p.productColors ?? const []) {
          if (c.colorName != null) {
            colors.putIfAbsent(c.colorName!, () => c.colorCode ?? '');
          }
        }
      }
      final prices = _all.map((p) => p.price ?? 0);
      return ProductFacetsModel(
        sizes: sizes,
        colors: [
          for (final e in colors.entries)
            FacetColorModel(name: e.key, hex: e.value),
        ],
        minPrice: prices.reduce((a, b) => a < b ? a : b).floorToDouble(),
        maxPrice: prices.reduce((a, b) => a > b ? a : b).ceilToDouble(),
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
