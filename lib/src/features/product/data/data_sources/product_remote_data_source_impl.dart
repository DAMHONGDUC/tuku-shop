import 'dart:math';

import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/mock/product_mock.dart';
import 'package:tuku_shop/src/features/product/data/mock/review_mock.dart';
import 'package:tuku_shop/src/features/product/data/models/product_color_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_page_model.dart';
import 'package:tuku_shop/src/features/product/data/models/review_model.dart';
import 'package:tuku_shop/src/features/product/data/models/reviews_page_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import 'product_remote_data_source.dart';

/// The catalogue "server": filters, sorts and pages [ProductMock.products]
/// the way a search API would.
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({
    List<ProductModel>? catalogue,
    DateTime Function()? clock,
  }) : _catalogue = catalogue ?? ProductMock.products,
       _clock = clock ?? DateTime.now;

  final List<ProductModel> _catalogue;
  final DateTime Function() _clock;

  static const int reviewsPageSize = 6;

  @override
  Future<ProductPageModel> getProducts(ProductQuery query) async {
    await MockLatency.normal();

    final List<ProductModel> matched = sort(
      filter(_catalogue, query),
      query.sort,
    );
    final int total = matched.length;
    final int totalPages = total == 0 ? 0 : (total / query.pageSize).ceil();
    final int start = (query.page - 1) * query.pageSize;

    return ProductPageModel(
      items: start >= total
          ? const <ProductModel>[]
          : matched.sublist(start, min(start + query.pageSize, total)),
      page: query.page,
      totalPages: totalPages,
      total: total,
    );
  }

  @override
  Future<ProductModel> getProductDetail(String id) async {
    await MockLatency.normal();

    final ProductModel? product = _catalogue.firstWhereOrNull(
      (ProductModel p) => p.id == id,
    );

    if (product == null) throw ServerException('Product $id not found');

    return product;
  }

  @override
  Future<List<ProductModel>> getProductsByIds(List<String> ids) async {
    await MockLatency.short();

    return <ProductModel>[
      for (final String id in ids)
        ?_catalogue.firstWhereOrNull((ProductModel p) => p.id == id),
    ];
  }

  @override
  Future<List<ProductModel>> getRelatedProducts(String id) async {
    await MockLatency.normal();

    final ProductModel? product = _catalogue.firstWhereOrNull(
      (ProductModel p) => p.id == id,
    );

    if (product == null) return const <ProductModel>[];

    final List<ProductModel> sameCategory = _catalogue
        .where(
          (ProductModel p) => p.id != id && p.categoryId == product.categoryId,
        )
        .toList();
    final List<ProductModel> sameGender = _catalogue
        .where(
          (ProductModel p) =>
              p.id != id &&
              p.categoryId != product.categoryId &&
              p.gender == product.gender,
        )
        .toList();

    return <ProductModel>[...sameCategory, ...sameGender].take(8).toList();
  }

  @override
  Future<({DateTime endsAt, List<ProductModel> products})>
  getFlashSale() async {
    await MockLatency.normal();

    final DateTime now = _clock();
    // The sale "ends" at the next 6-hour boundary, so the countdown is
    // always running and never longer than a few hours.
    final DateTime endsAt = DateTime(
      now.year,
      now.month,
      now.day,
      (now.hour ~/ 6 + 1) * 6,
    );
    final List<ProductModel> onSale =
        _catalogue.where((ProductModel p) => p.compareAtPrice != null).toList()
          ..sort(
            (ProductModel a, ProductModel b) =>
                _discount(b).compareTo(_discount(a)),
          );

    return (endsAt: endsAt, products: onSale.take(10).toList());
  }

  @override
  Future<ReviewsPageModel> getReviews({
    required String productId,
    required int page,
  }) async {
    await MockLatency.normal();

    final ProductModel product = _catalogue.firstWhere(
      (ProductModel p) => p.id == productId,
      orElse: () => throw ServerException('Product $productId not found'),
    );
    final List<ReviewModel> all = ReviewMock.forProduct(product);
    final Map<int, int> distribution = <int, int>{
      for (int s = 5; s >= 1; s--)
        s: all.where((ReviewModel r) => r.rating == s).length,
    };
    final int start = (page - 1) * reviewsPageSize;
    final double average = all.isEmpty
        ? 0
        : all.map((ReviewModel r) => r.rating ?? 0).sum / all.length;

    return ReviewsPageModel(
      average: double.parse(average.toStringAsFixed(1)),
      total: all.length,
      distribution: distribution,
      items: start >= all.length
          ? const <ReviewModel>[]
          : all.sublist(start, min(start + reviewsPageSize, all.length)),
      page: page,
      hasMore: start + reviewsPageSize < all.length,
    );
  }

  @override
  Future<List<String>> getTrendingSearches() async {
    await MockLatency.short();

    return const <String>[
      'Hoodie',
      'Running shorts',
      'Yoga pants',
      'Jacket',
      'Sports bra',
      'Backpack',
      'Tee',
    ];
  }

  // --- Query engine, public for tests ---

  static List<ProductModel> filter(
    List<ProductModel> products,
    ProductQuery query,
  ) {
    final List<String> tokens = query.keyword
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((String t) => t.isNotEmpty)
        .toList();

    return products.where((ProductModel p) {
      final double price = p.price ?? 0;

      if (query.categoryId != null && p.categoryId != query.categoryId) {
        return false;
      }
      if (query.gender != Gender.all &&
          p.gender != query.gender.name &&
          p.gender != Gender.unisex.name) {
        return false;
      }
      if (query.onSaleOnly && p.compareAtPrice == null) return false;
      if (query.newOnly && p.isNew != true) return false;
      if (query.minPrice != null && price < query.minPrice!) return false;
      if (query.maxPrice != null && price > query.maxPrice!) return false;
      if (query.sizes.isNotEmpty &&
          !(p.sizes ?? const <String>[]).any(query.sizes.contains)) {
        return false;
      }
      if (query.colors.isNotEmpty &&
          !(p.colors ?? const <ProductColorModel>[]).any(
            (ProductColorModel c) => query.colors.contains(c.name),
          )) {
        return false;
      }

      return tokens.every(
        (String token) => _haystack(p).contains(_stem(token)),
      );
    }).toList();
  }

  static List<ProductModel> sort(
    List<ProductModel> products,
    ProductSort sort,
  ) {
    final List<ProductModel> sorted = List<ProductModel>.of(products);

    int byScore(ProductModel a, ProductModel b) =>
        _score(b).compareTo(_score(a));

    switch (sort) {
      case ProductSort.recommended:
        sorted.sort(byScore);
      case ProductSort.newest:
        sorted.sort(
          (ProductModel a, ProductModel b) =>
              (b.createdAt ?? '').compareTo(a.createdAt ?? ''),
        );
      case ProductSort.priceLowHigh:
        sorted.sort(
          (ProductModel a, ProductModel b) =>
              (a.price ?? 0).compareTo(b.price ?? 0),
        );
      case ProductSort.priceHighLow:
        sorted.sort(
          (ProductModel a, ProductModel b) =>
              (b.price ?? 0).compareTo(a.price ?? 0),
        );
      case ProductSort.topRated:
        sorted.sort(
          (ProductModel a, ProductModel b) =>
              (b.rating ?? 0).compareTo(a.rating ?? 0),
        );
      case ProductSort.bestSelling:
        sorted.sort(
          (ProductModel a, ProductModel b) =>
              (b.soldCount ?? 0).compareTo(a.soldCount ?? 0),
        );
    }

    return sorted;
  }

  static String _haystack(ProductModel p) => <String?>[
    p.name,
    p.brand,
    p.categoryId,
    p.material,
    p.gender,
    if (p.gender == 'women') 'woman womens',
    if (p.gender == 'men') 'man mens',
    if (p.categoryId == 'tees') 't-shirt tshirt top',
    if (p.categoryId == 'tanks') 'bra top',
    if (p.categoryId == 'pants') 'leggings trousers jogger',
    if (p.categoryId == 'bags') 'backpack duffle',
    if (p.categoryId == 'hoodies') 'sweatshirt pullover',
    ...(p.colors ?? const <ProductColorModel>[]).map(
      (ProductColorModel c) => c.name,
    ),
  ].whereType<String>().join(' ').toLowerCase();

  /// "hoodies" finds "hoodie", "shorts" still finds "shorts".
  static String _stem(String token) => token.length > 4 && token.endsWith('s')
      ? token.substring(0, token.length - 1)
      : token;

  static double _score(ProductModel p) =>
      (p.rating ?? 0) * 20 +
      (p.soldCount ?? 0) / 100 +
      (p.isNew == true ? 15 : 0) +
      (p.compareAtPrice != null ? 8 : 0);

  static double _discount(ProductModel p) =>
      p.compareAtPrice == null ? 0 : 1 - (p.price ?? 0) / p.compareAtPrice!;
}
